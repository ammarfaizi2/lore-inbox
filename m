Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbRFLQDG>; Tue, 12 Jun 2001 12:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRFLQC4>; Tue, 12 Jun 2001 12:02:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2058 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262094AbRFLQCl>; Tue, 12 Jun 2001 12:02:41 -0400
Subject: Re: unused shared memory is written into core dump - bug or feature?
To: niemayer.viag@isg.de (Peter Niemayer)
Date: Tue, 12 Jun 2001 17:01:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B262158.29EFC01A@isg.de> from "Peter Niemayer" at Jun 12, 2001 04:04:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159qbN-0001Wk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you can be sure to never happen :-), it stymies the whole system,
> as the kernel first seems to map all the 512MB, then dumps them
> into the core file.

2.2.20pre dumps only the non zero pages and leaves holes for empty pages
2.4 likewise


