Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbRE0Rfj>; Sun, 27 May 2001 13:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262842AbRE0Rf3>; Sun, 27 May 2001 13:35:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2061 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262835AbRE0RfT>; Sun, 27 May 2001 13:35:19 -0400
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
To: bunk@fs.tum.de (Adrian Bunk)
Date: Sun, 27 May 2001 18:29:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.33.0105271903050.4227-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at May 27, 2001 07:25:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1544MV-00028h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On some architectures a function is inside an "#ifdef __KERNEL__" in the
> header file and on others not. Is there a reason for this or is this
> inconsistency simply a bug?

Its probably a bug - primarily it depends if the function is useful when
exported to non kernel code
