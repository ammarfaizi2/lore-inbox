Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264975AbUD2Vdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbUD2Vdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUD2Vdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:33:46 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:64140 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264975AbUD2Vct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:32:49 -0400
Date: Thu, 29 Apr 2004 17:32:46 -0400
From: Marc Boucher <marc@linuxant.com>
To: Timothy Miller <miller@techsource.com>
Cc: Rik van Riel <riel@redhat.com>, Marc Boucher <marc@linuxant.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040429213246.GA15988@valve.mbsi.ca>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40916495.1060805@techsource.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Colla wrote:
> Can you honestly tell apart the two cases, if you don't make a it a case of
> "religion war"?

On Thu, Apr 29, 2004 at 11:15:13AM -0400, Timothy Miller answered:
>
> Firmware downloaded into a piece of hardware can't corrupt the kernel in the
> host.
> 
> (Unless it's a bus master which writes to random memory, which might be
> possible, but there is hardware you can buy to watch PCI transactions.)

and unless it's a card with binary-only, proprietary BIOS code called at
runtime by the kernel, for example by the vesafb.c video driver,
which despite this has a MODULE_LICENSE("GPL").

Could someone explain why such execution of evil proprietary binary-only
code on the host CPU should not also "taint" the kernel? ;-)

Marc
