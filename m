Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287894AbSAMBF5>; Sat, 12 Jan 2002 20:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287892AbSAMBFr>; Sat, 12 Jan 2002 20:05:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33811 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287886AbSAMBFg>; Sat, 12 Jan 2002 20:05:36 -0500
Subject: Re: Unauthorized connection blocking withing socket
To: stao@nbnet.nb.ca (Senhua Tao)
Date: Sun, 13 Jan 2002 01:17:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3C40B526.D960AC26@nbnet.nb.ca> from "Senhua Tao" at Jan 12, 2002 06:13:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZH2-0003eQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure that it is a good idea to mess around sys_connect() or any
> one want to put such restriction on their computer. I don't see amy
> problem for the people who just use applications on their computers
> though. Any suggestion?

Most systems do this by role based security. You might want to have a look
at the LSM patch and the NSA security module, as well perhaps at the RSBAC
security project. The LSM and NSA modules can I suspect not only deal with
connect based cases but a lot more
