Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSDFRev>; Sat, 6 Apr 2002 12:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312643AbSDFReu>; Sat, 6 Apr 2002 12:34:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14096 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312638AbSDFRet>; Sat, 6 Apr 2002 12:34:49 -0500
Subject: Re: Init data debugging
To: pdh@berserk.demon.co.uk (Peter Horton)
Date: Sat, 6 Apr 2002 18:52:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020405170254.GA2092@berserk.demon.co.uk> from "Peter Horton" at Apr 05, 2002 06:02:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tuMF-0002L7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be feasible to add a kernel debugging option which rather than
> discarding init data/code sections just marked the pages as not
> accessible, so illegal accesses could be caught ?

Not efficiently. You can memset the pages to an illegal instruction which
does seem to help 
