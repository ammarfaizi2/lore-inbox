Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268644AbTGTWKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbTGTWKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:10:07 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:8710
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S268644AbTGTWKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:10:04 -0400
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Riley Williams <Riley@Williams.Name>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCAMEJJEPAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCAMEJJEPAA.Riley@Williams.Name>
Content-Type: text/plain
Message-Id: <1058739904.3987.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 15:25:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 14:04, Riley Williams wrote:
> When I did the "Assembler Language Maths Logic" module for my degree,
> we learned that processors used SRL (Shift Right Logical) to divide
> unsigned numbers by powers of 2, and SRA (Shift Right Arithmetic) to
> divide signed numbers by powers of 2. Can't GCC handle that?

Sure it can, but >>1 isn't the same as /2 for signed numbers.

(Hint: -1 / 2 != -1)

	J

