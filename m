Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312713AbSDFSpt>; Sat, 6 Apr 2002 13:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312716AbSDFSps>; Sat, 6 Apr 2002 13:45:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45480 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312713AbSDFSpr>;
	Sat, 6 Apr 2002 13:45:47 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 6 Apr 2002 18:45:11 GMT
Message-Id: <UTC200204061845.SAA545386.aeb@cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [WTF] ->setattr() locking changes
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    > Hmm...  While we are at it, why don't we remove suid/sgid on truncate(2)?

    Are there any standards saying either way? But yes, it sounds logical.

"This function shall not modify the file offset for any open file
 descriptions associated with the file. Upon successful completion,
 if the file size is changed, this function shall mark for update
 the st_ctime and st_mtime fields of the file, and the S_ISUID and
 S_ISGID bits of the file mode may be cleared."

Andries
