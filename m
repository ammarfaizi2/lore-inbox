Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313747AbSDICKs>; Mon, 8 Apr 2002 22:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313749AbSDICKs>; Mon, 8 Apr 2002 22:10:48 -0400
Received: from sitemail3.everyone.net ([216.200.145.37]:32924 "HELO
	omta01.mta.everyone.net") by vger.kernel.org with SMTP
	id <S313747AbSDICKr>; Mon, 8 Apr 2002 22:10:47 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Mon, 8 Apr 2002 19:10:47 -0700 (PDT)
From: mark manning <mark.manning@computermail.net>
To: linux-kernel@vger.kernel.org
Subject: syscals
Reply-To: mark.manning@computermail.net
X-Originating-Ip: [67.241.61.154]
Message-Id: <20020409021047.518A53ECC@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok - according to unistd.h we now have exactly 256 syscalls allocated (unless im missing something).  my code needs to be able to account for every single possible syscall and so i need to be able to store the syscall number in a standard way.  not all syscalls are catered for on the outset by at any time the user can say "i need to use syscall x which takes y parameters" and the code will be able to take care of it.

the problem is that i am currently reserving only 8 bits for the syscall number.  this is ok for now but if we ever get another syscall its going to be unuseable by my existing code :) - should i be reserving 16 bits now in preperation for some new syscalls being added ?
