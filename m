Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264621AbRFZAJf>; Mon, 25 Jun 2001 20:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbRFZAJZ>; Mon, 25 Jun 2001 20:09:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6916 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264621AbRFZAJM>; Mon, 25 Jun 2001 20:09:12 -0400
Subject: Re: Linux and system area networks
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Tue, 26 Jun 2001 01:08:47 +0100 (BST)
Cc: roland@hellmouth.digitalvampire.org, linux-kernel@vger.kernel.org
In-Reply-To: <200106252230.f5PMUDE26001@devserv.devel.redhat.com> from "Pete Zaitcev" at Jun 25, 2001 06:30:13 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EgPP-0002oq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a properly written host based stack works much better in
> the face of a changing environment: Faster CPUs, new CPUs
> (IA-64), new network protocols (ECN). Besides, it is easy
> to "accelerate" a bad network stack, but try to outdo a
> well done stack.

Putting the stack partly in user spacd can sometimes be a benefit. Linux 8086
does this to cut down kernel size for example ;)
