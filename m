Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131919AbQKTOkp>; Mon, 20 Nov 2000 09:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131960AbQKTOkf>; Mon, 20 Nov 2000 09:40:35 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:38833 "EHLO
	inet-smtp4.us.oracle.com") by vger.kernel.org with ESMTP
	id <S131919AbQKTOkX>; Mon, 20 Nov 2000 09:40:23 -0500
Message-ID: <3A1930D5.D74A40BB@oracle.com>
Date: Mon, 20 Nov 2000 15:10:29 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Spinillo <tspin@epix.net>
CC: Linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: isofs crash on 2.4.0-test11-pre7 [1.] MAINTAINERS: ISO 
 FILESYSTEM
In-Reply-To: <3A17C845.1A9845E9@epix.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Spinillo wrote:
> 
> Same problem as Vincent - OOPs when "ls" a mounted cdrom. It did work
> once with a CD-R. My report symptoms are nearly identical to previous
> post with same subject heading with a few differences:

there is a buglet in fs/isofs/namei.c, corrected in test11-final.

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.18p21/2.4.0-t11p7 glibc-2.1.94 gcc-2.95.2 binutils-2.10.0.33
Oracle: Oracle8i 8.1.6.1.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
