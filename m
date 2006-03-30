Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWC3PBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWC3PBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWC3PBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:01:53 -0500
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:9758 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1750766AbWC3PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:01:52 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>
Cc: "'Eric Piel'" <Eric.Piel@tremplin-utc.net>,
       "'Rob Landley'" <rob@landley.net>, <nix@esperi.org.uk>,
       <mmazur@kernel.pl>, <linux-kernel@vger.kernel.org>,
       <llh-discuss@lists.pld-linux.org>
Subject: RE: [OT] Non-GCC compilers used for linux userspace
Date: Thu, 30 Mar 2006 09:15:06 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcZSf1sjDrGCxhgJSGmNjY736+d6cQBjOT7w
Message-ID: <EXCHG20039aZbLAX3cf00000008@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 30 Mar 2006 14:54:13.0830 (UTC) FILETIME=[CF6FFE60:01C65409]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> Not even GCC fully supports C99 (although I think it does 
> support that keyword when passed -std=c99 or -std=gnu99), and 
> I suspect that a majority of the other compilers for which we 
> would want to add support in the kernel headers would not 
> support C99 or would do a poor job of handling inline functions.
> 
> But my question still stands.  Does anybody actually use any 
> non-GCC compiler for userspace in Linux?
> 
> Cheers,
> Kyle Moffett

Sometimes.

I have customers that use Pathscale, Intel, and Portland
groups compilers.

Not all of them use the C compilers (Some just use the F90
compilers), but a number of them do use the C compiler, though
I would be that most of the applications are not going to care
about doing much against anything but standard ANSI C calls.

                                Roger

