Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbSBCGEK>; Sun, 3 Feb 2002 01:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBCGEA>; Sun, 3 Feb 2002 01:04:00 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:16033 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S285783AbSBCGDy>; Sun, 3 Feb 2002 01:03:54 -0500
Message-ID: <3C5CD24C.6070506@wanadoo.fr>
Date: Sun, 03 Feb 2002 07:01:48 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Luis A. Montes" <Luis.A.Montes.1@worldnet.att.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 filesystem corruption
In-Reply-To: <200202030538.g135chu00602@penguin.montes2.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis A. Montes wrote:
> I have been experiencing filesystem corruption very frequently with
> 2.4.17. I've probably reinstalled my system more than 10 times in as
> many days. So far it seems to be related to the kernel version and
> perhaps to the UDMA settings. I haven't been able to crash the system
> running 2.4.5 or 2.2.19, but it has crashed with 2.4.17 every time,
> regardless of cpu optimization (Athlon, K6 or i386), AGP (built-in, as
> a module or not built), filesystem (ext2 or xfs).

The ext2 code diff in 2.4.18-pre7 solved it for me. I don't use xfs.

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

