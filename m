Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRBDRhn>; Sun, 4 Feb 2001 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRBDRhX>; Sun, 4 Feb 2001 12:37:23 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:30855 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129525AbRBDRhN>; Sun, 4 Feb 2001 12:37:13 -0500
Message-ID: <3A7D92EF.7D5BA02D@wanadoo.fr>
Date: Sun, 04 Feb 2001 18:35:43 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierfrancesco Caci <p.caci@tin.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 segfault when doing "ls /dev/"
In-Reply-To: <87u26avkfp.fsf@penny.ik5pvx.ampr.org>
		<3A7D5CFB.1C21ECD2@wanadoo.fr> <87lmrmv984.fsf@penny.ik5pvx.ampr.org>
		<3A7D7BCE.37F3DDF@wanadoo.fr> <87g0huv2ek.fsf@penny.ik5pvx.ampr.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierfrancesco Caci wrote:

> Yes I know this. Actually, booting with "devfs=nomount s" is the only
> way to update the boot record with lilo and my existing lilo.conf.

i can't do that on my box, /dev is only a mount point for devfs.

assuming your /dev directory is dirty from something else than devfsd,
could you try this while devfsd is running :
#mkdir /devtest
#mount none -t devfs /devtest
#ls /devtest

-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
