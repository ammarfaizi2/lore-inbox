Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280659AbRKSTm2>; Mon, 19 Nov 2001 14:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280662AbRKSTmT>; Mon, 19 Nov 2001 14:42:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25103 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280659AbRKSTmH>; Mon, 19 Nov 2001 14:42:07 -0500
Subject: Re: Memory allocation question
To: george@mvista.com (george anzinger)
Date: Mon, 19 Nov 2001 19:50:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3BF95C48.C49B3AE1@mvista.com> from "george anzinger" at Nov 19, 2001 11:23:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165uQj-0007V2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> size chuncks.  Currently I am using kmalloc() to allocate a page at a
> time.  I don't want to have to worry about mapping/unmapping etc.  I

Use get_free_page() to get page sized chunks
