Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293361AbSCOVyx>; Fri, 15 Mar 2002 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293362AbSCOVyn>; Fri, 15 Mar 2002 16:54:43 -0500
Received: from palrel12.hp.com ([156.153.255.237]:7394 "HELO palrel12.hp.com")
	by vger.kernel.org with SMTP id <S293361AbSCOVyc>;
	Fri, 15 Mar 2002 16:54:32 -0500
From: "Jim Hollenback" <jholly@cup.hp.com>
Message-Id: <1020315135426.ZM923@fry.cup.hp.com>
Date: Fri, 15 Mar 2002 13:54:26 -0800
X-Mailer: Z-Mail (5.0.0 30July97)
To: linux-kernel@vger.kernel.org
Subject: readv() return and errno
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 In doing some testing on the project I'm working on I came
 across something that is causing a bit of confusion on my part.

 According to readv(2) EINVAL is returned for an invalid
 argument.  The examples given were count might be greater than
 MAX_IOVEC or zero. The test case I am working with has count = 0
 and I get return of 0 and errno 0 instead of the expected -1
 and errno EINVAL.

 Am I missing something?

Thanks!

Jim Hollenback
