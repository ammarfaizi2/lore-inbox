Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVIFThq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVIFThq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVIFThq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:37:46 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:51633 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750824AbVIFThq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:37:46 -0400
Date: Tue, 6 Sep 2005 21:37:42 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: vortex@scyld.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: wakeup on lan enable without compiling as module
Message-ID: <20050906193742.GA16229@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	vortex@scyld.com, LKML <linux-kernel@vger.kernel.org>
References: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

* Thomas Glanzmann <sithglan@stud.uni-erlangen.de> [050906 20:53]:
> I would like to build the 3c59x vortex module into the kernel (not as
> module) but don't loose the ability to use wakeup-on-lan. Because it
> seems to be impossible to specify 'module parameters' to a built-in
> kernel module I tried the following patch, which doesn't work for me.
> Could someone enlighten me how I can get the expected behaviour?

I just got a private eMail with the solution. You can provide module
parameters using the following syntax:

	3c59x.enable_wol=1

and it works as expected.

Thanks,
	Thomas
