Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTECSaG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTECSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:30:06 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:56017 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263365AbTECSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:30:03 -0400
Date: Sat, 3 May 2003 15:52:12 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andi Kleen <ak@muc.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk11: .text.exit errors in .altinstructions
Message-ID: <20030503155212.Q626@nightmaster.csn.tu-chemnitz.de>
References: <20030502171355.GU21168@fs.tum.de> <20030502185229.GA27169@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030502185229.GA27169@averell>; from ak@muc.de on Fri, May 02, 2003 at 08:52:29PM +0200
X-Spam-Score: -32.2 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C1xt-0007UH-00*uMf7bDzPrOQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 08:52:29PM +0200, Andi Kleen wrote:
> The only fix I know currently is to remove the .exit.text
> discard from arch/i386/vmlinux.lds.S. It'll increase the kernel
> text size slightly because functions that would only be needed
> for module unload in some drivers will be compiled in too. 
> But it's probably not too bad, at worst a few KB.

What is that .altinstructions stuff?

I'm having a hard time to understand, what it should do, and why
it is desperately needed.

Regards

Ingo Oeser
