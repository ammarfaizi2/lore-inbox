Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVKCIqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVKCIqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVKCIqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:46:04 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:16044 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751149AbVKCIqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:46:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Rudo Thomas <rudo@matfyz.cz>
Subject: Re: 2.6.14-ck1
Date: Thu, 3 Nov 2005 19:47:44 +1100
User-Agent: KMail/1.8.3
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
References: <200510282118.11704.kernel@kolivas.org> <200511030951.00679.kernel@kolivas.org> <20051103083430.GA16957@jikos.cz>
In-Reply-To: <20051103083430.GA16957@jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031947.44745.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005 07:34 pm, Rudo Thomas wrote:
> > > Con,any recommended value for /proc/sys/kernel/readahead_ratio, or
> > > is it automagicly set?It's value is 0 ATM.
> >
> > Yes. First it's supposed to be in /proc/sys/vm (my fault on the
> > merge), and it should be set to about 50. All this is corrected in
> > 2.6.14-ck2 which has the new readahead code, the tunable in the
> > correct location, and the default set to 50.
>
> Con, it's still in /proc/sys/kernel in ck2, AFAICT.

Bah you're right. Thanks for the heads up. It will work the same there; it's 
just not meant to be there. Anyway I don't think you'll need to be fiddling 
with the default value generally.

Cheers,
Con
