Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274227AbRISW03>; Wed, 19 Sep 2001 18:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274229AbRISW0T>; Wed, 19 Sep 2001 18:26:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274227AbRISW0H>; Wed, 19 Sep 2001 18:26:07 -0400
Subject: Re: broken VM in 2.4.10-pre9
To: rfuller@nsisoftware.com (Rob Fuller)
Date: Wed, 19 Sep 2001 23:30:41 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), ebiederm@xmission.com,
        alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com> from "Rob Fuller" at Sep 19, 2001 05:15:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jprd-00042O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "One argument for reverse mappings is distributed shared memory or
> distributed file systems and their interaction with memory mapped files.
> For example, a distributed file system may need to invalidate a specific
> page of a file that may be mapped multiple times on a node."

Wouldn't it be better for the file system itself to be doing that work. Also
do real world file systems that actually perform usably do this or just zap
the cached mappings like OpenGFS does.

Alan
