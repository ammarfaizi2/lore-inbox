Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTJUB0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTJUB0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:26:22 -0400
Received: from [139.30.44.16] ([139.30.44.16]:23426 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263062AbTJUB0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:26:21 -0400
Date: Tue, 21 Oct 2003 03:26:18 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: George Glover <gloverge@baldwinlib.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 aacraid help
In-Reply-To: <35351.68.40.98.164.1066698173.squirrel@mail.baldwinmail.org>
Message-ID: <Pine.LNX.4.53.0310210324460.11649@gockel.physik3.uni-rostock.de>
References: <35351.68.40.98.164.1066698173.squirrel@mail.baldwinmail.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's an Adaptec 2200S, with 5 U320 drives connected (seperate channels
> 3/2).  Each drive seems to read ~70MB/s on it's own, both through the
> aacraid driver and through the onboard fusion mpt controller.  Using
> hardware raid 10 with aacraid reads ~100MB/s, it seems to go no faster -
> regardless of raid levels.  However with software raid, I can nearly
> double that (half on aacraid, half onboard)  I am not able to test it with
> all drives using the onboard controller with software raid due to lack of
> cables and not wanting to destroy the boot drive.
>
> I am wondering if there is a magical go faster button that I'm missing?

Maybe you just max out PCI Bandwith?

Tim
