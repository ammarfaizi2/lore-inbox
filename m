Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTLWSsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLWSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:48:21 -0500
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:10491 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262280AbTLWSsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:48:08 -0500
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Re: Prevailence of PS/2 Active Muxed devices?
Date: Tue, 23 Dec 2003 13:47:33 -0500
User-Agent: KMail/1.5.4
References: <20031223180429.GA11198@dreamland.darkstar.lan> <200312231325.39712.jcwren@jcwren.com>
In-Reply-To: <200312231325.39712.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231347.33818.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Naturally, after spending 45 minutes looking through mouse and keyboard 
sources in 2.4.21 on the laptop, I find it in i8042.c in the 2.6 tree.

	Now to see if something can actually be done with it...

	--jc

On Tuesday 23 December 2003 13:25 pm, J.C. Wren wrote:
> 	I have an application where I'd like to specifically control which PS/2
> aux device data is sent/received from/to.  Particularly, on a laptop that
> has an integrated touch pad, I'd like to select the external mouse port.
>
> 	This document http://www.synaptics-uk.com/decaf/utilities/ps2-mux.PDF
> describes what appears to be a rather well thought method for multiple aux
> devices on a single KBC.
>
> 	Looking through the kernel sources, I see no handling for this.  From a
> big picture perspective, how does Linux handle a system with an integrated
> mouse pad, and an external PS/2 mouse port?  Is this whole Synaptics idea
> dead, or is support for this planned, or even considered?  Does any one
> have any knowledge the number of KBCs with this muxing?
>
> 	Seeing some of the parties that partcipated in the standards, it would be
> a touch surprising if it just completely died.
>
> 	--jc
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

