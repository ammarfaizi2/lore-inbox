Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130375AbRBRMZD>; Sun, 18 Feb 2001 07:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131776AbRBRMYw>; Sun, 18 Feb 2001 07:24:52 -0500
Received: from [212.17.18.2] ([212.17.18.2]:26635 "EHLO technoart.net")
	by vger.kernel.org with ESMTP id <S130375AbRBRMYo>;
	Sun, 18 Feb 2001 07:24:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: fsync vs fdatasync on Linux
Date: Sun, 18 Feb 2001 18:22:59 +0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01021818225902.00766@dyp.perchine.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as fas as I can see from fdatasync man page, and from the latest kernel 
sources (2.4.1ac3, fs/buffer.c), they are equivalent.

Using of fdatasync in database can gain significant gain on systems which 
supports it (on HP it gains up to 25% with pg_bench on PostgreSQL 7.1b5).

Are there any plans to implement this correctly? And due to what problems it 
was not implemented yet?

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
