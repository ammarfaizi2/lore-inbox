Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVBAN7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVBAN7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBAN7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:59:03 -0500
Received: from nn6.excitenetwork.com ([207.159.120.60]:41495 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S262019AbVBAN67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:58:59 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem in accessing executable files
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 41790ee39c7967bbf4ef314fad615410
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-c-programming@vger.kernel.org
Message-Id: <20050201135857.154ED1E491@xprdmailfe25.nwk.excite.com>
Date: Tue,  1 Feb 2005 08:58:57 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am trying to add some cryptographic functionality to ext2 file system for my masters project. I am working with kernel 2.4.21

since the routines do_generic_file_read and do_generic_file_write are used in reading and writing, I am decrypting and encrypting the data in the resp. functions. This is working fine for regular data files. If I try to copy / execute executable files, I am getting segmentation fault. In kernel messages, I see same functions (read and write) getting called for the executables also. If I comment encrypt/decrypt functions, its working fine.

Now since it is working for regular text files, I suppose there is not a problem in my encrypt/decrypt routines, then what might be going wrong?

Thanks and regards,

Vineet

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
