Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316635AbSFVBNy>; Fri, 21 Jun 2002 21:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSFVBNx>; Fri, 21 Jun 2002 21:13:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316635AbSFVBNx>; Fri, 21 Jun 2002 21:13:53 -0400
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
To: jch@pps.jussieu.fr (Juliusz Chroboczek)
Date: Sat, 22 Jun 2002 02:36:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206141346.g5EDklY65153@helium.pps.jussieu.fr> from "Juliusz Chroboczek" at Jun 14, 2002 03:46:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LZp3-00021c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With current Linux kernels, this careful coding brings no benefit
> whatsover, as malloc never (?) returns NULL.  What is worse, as far as
> I know the kernel doesn't send advance warning of an OOM situation; it
> would not be too difficult to stop allocating memory when that happens.

With properly configured systems and mode 2/3 overcommit set you an
get NULL back from malloc Its up to the user
