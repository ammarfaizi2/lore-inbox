Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277945AbRJKCsj>; Wed, 10 Oct 2001 22:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277991AbRJKCs3>; Wed, 10 Oct 2001 22:48:29 -0400
Received: from 157-151.nwinfo.net ([216.187.157.151]:28050 "EHLO
	mail.morcant.org") by vger.kernel.org with ESMTP id <S277976AbRJKCs0>;
	Wed, 10 Oct 2001 22:48:26 -0400
Message-ID: <35731.24.255.76.12.1002768539.squirrel@webmail.morcant.org>
Date: Wed, 10 Oct 2001 19:48:59 -0700 (PDT)
Subject: 2.4.11 UDF
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <01101018290109.11498@localhost.localdomain>
In-Reply-To: <01101018290109.11498@localhost.localdomain>
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recieve the following when mounting The Matrix:

Oct 10 19:40:40 ember kernel: UDF-fs INFO UDF 0.9.4.1-ro (2001/06/13) Mounting volume
'THE_MATRIX_16X9LB_N_AMERICA', timestamp 1999/08/02 17:29 (1e5c)

However, upon ls, I get an empty directory and the following errors dumped to syslog:

Oct 10 19:40:41 ember kernel: UDF-fs DEBUG directory.c:237:udf_get_fileident: 0x0 !=
TID_FILE_IDENT_DESC
Oct 10 19:40:41 ember kernel: UDF-fs DEBUG directory.c:239:udf_get_fileident: offset: 532
sizeof: 38 bufsize: 2048

I can however mount the 5th Element and I see the following, and recieve no errors and a
correct ls.
Oct 10 19:44:11 ember kernel: UDF-fs INFO UDF 0.9.4.1-ro (2001/06/13) Mounting volume
'DVD_VIDEO', timestamp 1997/10/28 11:44 (1e5c)

I didn't use UDF in 2.4.10, so perhaps this has already been discussed, if so clue me in :>

-- 
Morgan Collins [Ax0n] http://sirmorcant.morcant.org
Software is something like a machine, and something like mathematics, and something like
language, and something like thought, and art, and information.... but software is not in
fact any of those other things.

