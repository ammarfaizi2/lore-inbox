Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSBNMXW>; Thu, 14 Feb 2002 07:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291549AbSBNMXM>; Thu, 14 Feb 2002 07:23:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11794 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291547AbSBNMXB>; Thu, 14 Feb 2002 07:23:01 -0500
Subject: Re: Linux 2.4.18-pre9-mjc2
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 14 Feb 2002 12:36:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020214114335.GA4058@merlin.emma.line.org> from "Matthias Andree" at Feb 14, 2002 12:43:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bL89-0008Jl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > lm_sensors				(lm_sensors team)
> 
> Hum, the last time I merged that stuff into my own kernel, the
> patch-generator that they ship did not include all of the drivers I
> needed. Also, I'm missing i2c from your patch list. Is that intentional
> or is the i2c patch not needed? Which lm_sensors version did you merge?

Be very careful merging lm_sensors. Incorrect use of it is a wonderful
way to do things like totally destroy (back to factory) an ibm thinkpad.
Thats why I've always stayed clear of it
