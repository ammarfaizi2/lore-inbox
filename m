Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbRGNPJJ>; Sat, 14 Jul 2001 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRGNPJB>; Sat, 14 Jul 2001 11:09:01 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:22186 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263346AbRGNPIu>; Sat, 14 Jul 2001 11:08:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Sat, 14 Jul 2001 11:08:34 -0400
X-Mailer: KMail [version 1.2.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010714150834.9A8D349E9@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2001, Paul Jakma wrote:
>On Fri, 13 Jul 2001, Andreas Dilger wrote:

>> put your journal on NVRAM, you will have blazing synchronous I/O.

>so ext3 supports having the journal somewhere else then. question: can
>the journal be on tmpfs?

Why would you want too?  You _need_ the journal after a crash to recover
without an fsck - if its on tmpfs you are SOL...

Ed Tomlinson
