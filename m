Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280213AbRJaOBG>; Wed, 31 Oct 2001 09:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280226AbRJaOA4>; Wed, 31 Oct 2001 09:00:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5135 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280213AbRJaOAp>; Wed, 31 Oct 2001 09:00:45 -0500
Subject: Re: AMD SMP Support ?
To: mschwarz_contron@yahoo.de (=?iso-8859-1?q?Marco=20Schwarz?=)
Date: Wed, 31 Oct 2001 14:08:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011031133744.78351.qmail@web10303.mail.yahoo.com> from "=?iso-8859-1?q?Marco=20Schwarz?=" at Oct 31, 2001 02:37:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yw2G-0003oi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Does the current kernel support Dual Athlon CPUs ?

Yes.

> - Is it possible to build one kernel for dual Athlon,
> single Athlon, dual PIII and single PIII boxes ? 

Yes. Build an SMP PII kernel and all should be fine. It won't make use
of the athlon optimisations and you'll pay the SMP overhead on all boxes
but its an acceptable trade off for easy management in most cases
