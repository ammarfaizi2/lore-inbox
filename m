Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSDEAEW>; Thu, 4 Apr 2002 19:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDEAEN>; Thu, 4 Apr 2002 19:04:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310666AbSDEAEG>; Thu, 4 Apr 2002 19:04:06 -0500
Subject: Re: faster boots?
To: joeja@mindspring.com
Date: Fri, 5 Apr 2002 01:21:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net> from "joeja@mindspring.com" at Apr 04, 2002 06:54:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tHTh-00078b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Is there some way of making the linux kernel boot faster?  

#1: Start less crap at boot time. Obvious but thats frequently most of
    the issue.

For Red Hat if your hardware set up is constant then rpm -e kudzu will do
no harm and avoid the grovelling through the box looking for new toys.

Longer term swsuspend means you can bang alt-sysrq-Z and suspend to disk
without BIOS support
