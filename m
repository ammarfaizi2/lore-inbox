Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVALPcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVALPcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVALPcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:32:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:29080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261223AbVALPcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:32:22 -0500
Date: Wed, 12 Jan 2005 07:32:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc1
In-Reply-To: <200501121824.44327.rathamahata@ehouse.ru>
Message-ID: <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
 <200501121824.44327.rathamahata@ehouse.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Sergey S. Kostyliov wrote:
> 
> 2.6.10-rc1 hangs at boot stage for my dual opteron machine

Oops, yes. There's some recent NUMA breakage - either disable CONFIG_NUMA, 
or apply the patches that Andi Kleen just posted on the mailing list (the 
second option much preferred, just to verify that yes, that does fix it).

		Linus
