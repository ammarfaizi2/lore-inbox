Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265225AbRF0JiV>; Wed, 27 Jun 2001 05:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265229AbRF0JiM>; Wed, 27 Jun 2001 05:38:12 -0400
Received: from Expansa.sns.it ([192.167.206.189]:6405 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265225AbRF0Jhv>;
	Wed, 27 Jun 2001 05:37:51 -0400
Date: Wed, 27 Jun 2001 11:37:23 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Kenneth Johansson <ken@canit.se>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: EXT2 Filesystem permissions (bug)?
In-Reply-To: <3B390B48.D444B7C5@canit.se>
Message-ID: <Pine.LNX.4.33.0106271132200.17888-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Kenneth Johansson wrote:

> Interesting but I wonder how much this helps someone that not already know what it is. Should not the ls manual also contain something that explains the meaning instead of just the mapping from bits to symbol.
>
> Do linux even support the sticky bit (t) I can't see a reason to use it, why would I want the file to be stored in the swap ??
>
??????
if i have a sticky bit on a directory where every user has permission to
write, and i write a file, that i will be the only one able to
modify/delete my file.
If there is no sticky bit on the directory, then every one is able to
manipulate my file.

How is this related to swap?

usually the sticky bit is used for /tmp /var/tmp, where it has to be used
for security reasons.

Maybe you are making confusion because some other Unix use the /tmp
partition with a special FS to use it also as a swap area (Slowlaris for
expample, the old, old, old HP-UX pre 7.X versions and so on), and
of course /tmp has the sticky be setted.
If i am wrong with my supposition, excuse me.

Luigi

