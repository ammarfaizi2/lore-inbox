Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTKMSNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKMSNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:13:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:16091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264364AbTKMSNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:13:12 -0500
Date: Thu, 13 Nov 2003 10:13:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jochen Voss <voss@seehuhn.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
In-Reply-To: <20031113180442.GA2161@seehuhn.de>
Message-ID: <Pine.LNX.4.44.0311131009450.8093-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Nov 2003, Jochen Voss wrote:
> 
> With the patch the crash goes away, but I get the error message
> 
>     BIOS bug, MP table errors detected!...
>     ... disabling SMP support. (tell your hw vendor)
> 
> now.  I guess that means no hyperthreading for me :-(

Hmm.. Do you have ACPI enabled? We really shouldn't need the MP table if 
the information is elsewhere, but the mptable assumptions might be a bit 
entrenched.

		Linus

