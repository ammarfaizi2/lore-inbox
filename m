Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277030AbRJHRrV>; Mon, 8 Oct 2001 13:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277034AbRJHRrK>; Mon, 8 Oct 2001 13:47:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40719 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277030AbRJHRq7>; Mon, 8 Oct 2001 13:46:59 -0400
Subject: Re: [PATCH] Provide system call to get task id
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 8 Oct 2001 18:52:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dmccr@us.ibm.com (Dave McCracken),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0110081042430.8212-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 08, 2001 10:44:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qeaA-0001IU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll add a gettid(), except I won't be moving reserved system calls
> around. I didn't even realize I had removed gettid - it was there in the
> 2.4.0-test kernels that implemented the signal groups, and I meant to only
> revert the unsafe signals stuff..

Would it make more sense to add a getpid() and make the existing one
gettid() to keep compatibility at its sanest ?
