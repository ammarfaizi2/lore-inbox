Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTDILhG (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTDILhG (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:37:06 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:15242 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263015AbTDILhF (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:37:05 -0400
Subject: Re: 2.5: Can't unmount fs after using NFS
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <16016.61751.120794.728107@notabene.cse.unsw.edu.au>
References: <1049036587.600.9.camel@teapot>
	 <16016.61751.120794.728107@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Organization: 
Message-Id: <1049888885.608.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 09 Apr 2003 13:48:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 05:32, Neil Brown wrote:
> On  March 30, felipe_alfaro@linuxmail.org wrote:
> > Hi,
> > 
> > Since I started testing 2.5 on my NFS server, I'm having problems
> > unmounting filesystems that were exported by NFS (of course, before
> > trying to unmount, I stopped NFS):
> 
> Thankyou for the bug report.  After spending far too long looking in
> the wrong place, I looked in the right place and found it.
> This patch should fix it.

I'm sorry to say the patch doesn't fix the problem. After sometime under
normal usage of the NFS server, I can't still unmount the volume after
stopping the NFS service.

Do you want me to do anything else?

________________________________________________________________________
Linux Registered User #287198

