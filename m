Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVHBG5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVHBG5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVHBG5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:57:49 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:1337 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbVHBG5t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:57:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PH8emBkt7aGOhhmfXhLqNAAxNfsZZZUouDnOcnwD/hZEWqyloc2Lbp2Pt8X0vtZzbjLIdwV7j0tMIwCEjPbJMTXThOzoBd9gZKkp6swbJ15OIxo1lFVgZqai0bXka3Fq6WmFqW8FHPEtwUn65hu01+3rVnUZfiHL6z/jKDONIvg=
Message-ID: <4ae3c14050801235711055125@mail.gmail.com>
Date: Tue, 2 Aug 2005 02:57:47 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is it possible to get the return address in a system call function?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me clarify with an example: 

test.c:

******
open("abc.txt", O_RDONLY);
i ++;

Apparently, after the system call  "open" in the kernel, the system
will return to the instruction "i++".  My question is: can we find out
the instruction pointer in  sys_open? If so, how?

Thanks!

xin
