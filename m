Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267752AbTAMB3H>; Sun, 12 Jan 2003 20:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTAMB3H>; Sun, 12 Jan 2003 20:29:07 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:126 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267752AbTAMB3G>; Sun, 12 Jan 2003 20:29:06 -0500
Message-ID: <3E22183D.3090907@blue-labs.org>
Date: Sun, 12 Jan 2003 20:37:01 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.56 panics PostgreSQL
References: <3E21B839.4060902@blue-labs.org>	 <200301121137.07735.akpm@digeo.com>  <3E21C794.6070606@blue-labs.org> <1042420508.31100.1180.camel@tiny.suse.com>
In-Reply-To: <1042420508.31100.1180.camel@tiny.suse.com>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just for clarification, the kernel isn't OOPSing, PostgreSQL is the one 
having fits and shutting down/starting up left and right.

The NMI is the only kernel indication that something is odd.  Which 
never happens under 2.4.

David

Chris Mason wrote:

>On Sun, 2003-01-12 at 14:52, David Ford wrote:
>  
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Reiserfs.  Postgres is the only program that had problems, but it's also
>>the one that does 99% of all the activity on the system.
>>    
>>
>
>Do you still have any of the oopsen?
>
>-chris
>
>  
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Ihg974cGT/9uvgsRAqaRAKCD3JLmwwOEpoDBebPyDs2QWGZSGgCff7yN
+g3+aIX6Y8DHkcj3ZFPpivI=
=86PN
-----END PGP SIGNATURE-----

