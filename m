Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVF3NPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVF3NPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVF3NPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:15:11 -0400
Received: from web8409.mail.in.yahoo.com ([202.43.219.157]:34158 "HELO
	web8409.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262705AbVF3NO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:14:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tzYaq+LSEvTg/e+OjwZYjIVBtBtZeGEkRLxOPEk8nyatvcNSarFSvy3Kz4lGZLktgh0K7Rf/jXed8xKf9dR5H2MFfEOM04XuIpvEiZNoR2a4HmnfroiqAGEIguTKTPWDzsShwEMJrX/h9PyrBt//Shyphz7ZnHB1n9GMqFKprAA=  ;
Message-ID: <20050630131419.43354.qmail@web8409.mail.in.yahoo.com>
Date: Thu, 30 Jun 2005 14:14:19 +0100 (BST)
From: KV Pavuram <kvpavuram@yahoo.co.in>
Subject: Pthreadid, pid
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When i run a multi-threaded program from gdb, gdb
shows "New Thread XXXXXXXX (LWP LLLL)" for each new
thread created by the application.

However, when I run ps -aelfm, the output shows each
thread of this application but with a different PID.

And, getpid () in each thread inside the application
always retreives the same PID.

What is the relation between LWP is given by GDB, PID
shown by ps call and the PID returned by getpid ().

Is there any system call to obtain one from the
other??

The problem occurs when i run strace on one the
threads using PID given by ps command. I cant run
application through GDB for strace to work. So i am
not able to match the strace output to a particular
thread in my application. 

Thanks.
Pav.


		
__________________________________________________________
How much free photo storage do you get? Store your friends 'n family snaps for FREE with Yahoo! Photos http://in.photos.yahoo.com
