Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUEAT1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUEAT1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUEAT1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 15:27:45 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:55213 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261947AbUEAT1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 15:27:44 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 1 May 2004 12:27:41 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Marc Boucher <marc@linuxant.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.58.0405011223490.10888@bigblue.dev.mdolabs.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
 <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
 <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <6900000.1083388078@[10.10.2.4]>
 <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Marc Boucher wrote:

> One of them redirects the messages to a separate file and appends
> the following notice:
> 
>  > ********************************************************************
>  > * You can safely ignore the above message about tainting the kernel.
>  > * It is completely political and means just that the maintainers of
>  > * of modutils package dislike software that is not distributed under
>  > * an open source license.
>  > ********************************************************************

Right that you're there, you might want also to add something like:

*************************************************************************
* Do not even try to report your problems with the Linux kernel to software
* maintainers at linux-kernel@vger.kernel.org since they cannot do anything
* about modules they do not have the source of. Reports your problems at:
*
* LIST-OF-BINARY-MODULES-DROPPERS-EMAIL-ADDRESSES
*************************************************************************

#define MODULE_CONTACT(...)



- Davide

