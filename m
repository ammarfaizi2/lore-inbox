Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVKCIei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVKCIei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVKCIei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:34:38 -0500
Received: from twin.jikos.cz ([213.151.79.26]:2945 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751015AbVKCIeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:34:37 -0500
Date: Thu, 3 Nov 2005 09:34:30 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: 2.6.14-ck1
Message-ID: <20051103083430.GA16957@jikos.cz>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
	linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
References: <200510282118.11704.kernel@kolivas.org> <20051102213814.15724994.predivan@ptt.yu> <200511030951.00679.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511030951.00679.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Con,any recommended value for /proc/sys/kernel/readahead_ratio, or
> > is it automagicly set?It's value is 0 ATM.
> 
> Yes. First it's supposed to be in /proc/sys/vm (my fault on the
> merge), and it should be set to about 50. All this is corrected in
> 2.6.14-ck2 which has the new readahead code, the tunable in the
> correct location, and the default set to 50. 

Con, it's still in /proc/sys/kernel in ck2, AFAICT.

Rudo.
