Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRFSPY7>; Tue, 19 Jun 2001 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264317AbRFSPYt>; Tue, 19 Jun 2001 11:24:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36879 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264303AbRFSPYl>; Tue, 19 Jun 2001 11:24:41 -0400
Subject: Re: Linux 2.2.20-pre4
To: jochen@tolot.escape.de (Jochen Striepe)
Date: Tue, 19 Jun 2001 16:23:44 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010619172219.A18744@tolot.escape.de> from "Jochen Striepe" at Jun 19, 2001 05:22:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CNM0-00067q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just to keep you informed... (I think there was a saying that there was
> interest in experiences with compiling the kernel with non-recommended
> gcc's ...)


> sched.c:52: conflicting types for `xtime'
> /usr/src/linux/include/linux/sched.h:509: previous declaration of `xtime'

Stick a volatile in the declaration. Thats a real bug it found
