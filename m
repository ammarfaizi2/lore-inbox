Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279626AbRJXWNo>; Wed, 24 Oct 2001 18:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279619AbRJXWN3>; Wed, 24 Oct 2001 18:13:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279618AbRJXWNU>; Wed, 24 Oct 2001 18:13:20 -0400
Subject: Re: 2.4.13: some compilerwarnings...
To: andre.dahlqvist@telia.com (=?iso-8859-1?Q?Andr=E9?= Dahlqvist)
Date: Wed, 24 Oct 2001 23:20:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel Development Mailinglist)
In-Reply-To: <20011025201508.B11646@telia.com> from "=?iso-8859-1?Q?Andr=E9?= Dahlqvist" at Oct 25, 2001 08:15:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wWNl-0002oA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sven Vermeulen <sven.vermeulen@rug.ac.be> wrote:
> 
> > {standard input}:1040: Warning: indirect lcall without `*'
> > {standard input}:1125: Warning: indirect lcall without `*'
> > {standard input}:1208: Warning: indirect lcall without `*'
> 
> I think Alan once mentioned that this was sort of a feature to make old
> versions of binutils work too. I'm not sure exactly how old those are
> though, and if they are older than the recommended 2.9.1.0.25 I vote fo=
> r
> fixing these ugly warnings.

Kill them in 2.5, there really isnt a hurry. If it bugs you that much
write yourself a scripts/asm AS:= target that is as 2>&1 | grep -v 8)
