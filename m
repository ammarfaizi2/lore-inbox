Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSENRnp>; Tue, 14 May 2002 13:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315924AbSENRno>; Tue, 14 May 2002 13:43:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64007 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315923AbSENRnm>; Tue, 14 May 2002 13:43:42 -0400
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: chen_xiangping@emc.com (chen, xiangping)
Date: Tue, 14 May 2002 19:02:48 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), jes@wildopensource.com,
        Steve@ChyGwyn.com, linux-kernel@vger.kernel.org
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A54@srgraham.eng.emc.com> from "chen, xiangping" at May 14, 2002 01:36:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177gdM-0008Sw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But ... It seems that there is no direct way to adjust the tcp max 
> window size in Linux kernel.

setsockopt SO_SNDBUF and SO_RCVBUF - same as all Unix and unixlike boxes
