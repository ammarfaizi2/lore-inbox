Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264532AbRGBMfL>; Mon, 2 Jul 2001 08:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRGBMew>; Mon, 2 Jul 2001 08:34:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264169AbRGBMes>; Mon, 2 Jul 2001 08:34:48 -0400
Subject: Re: [PATCH] more SAK stuff
To: Andries.Brouwer@cwi.nl
Date: Mon, 2 Jul 2001 13:33:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, andrewm@uow.edu.au, torvalds@transmeta.com,
        tytso@mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200107021216.OAA512638.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Jul 02, 2001 02:16:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15H2sv-0005pG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (a) It does less, namely will not kill processes with uid 0.
> Ted, any objections?

That breaks the security guarantee. Suppose I use a setuid app to confuse 
you into doing something ?



