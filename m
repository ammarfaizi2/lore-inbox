Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312833AbSCZXbu>; Tue, 26 Mar 2002 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSCZXbj>; Tue, 26 Mar 2002 18:31:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312838AbSCZXbG>; Tue, 26 Mar 2002 18:31:06 -0500
Subject: Re: readv() return and errno
To: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 23:38:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, jholly@cup.hp.com, balbir_soni@yahoo.com,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        plars@austin.ibm.com
In-Reply-To: <UTC200203262137.VAA421173.aeb@cwi.nl> from "Andries.Brouwer@cwi.nl" at Mar 26, 2002 09:37:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q0W5-0004CJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The man page is buggy if anything is.
> 
> Hmm. So far nobody pointed out anything buggy.
> Now that I look myself I see outdated prototypes
> (like int instead of ssize_t).
> What else did you find buggy?

Specifying zero vectors is not an error in Linux (and not required to be
by SuSv3)

