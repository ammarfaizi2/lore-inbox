Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbRETUvV>; Sun, 20 May 2001 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261986AbRETUvL>; Sun, 20 May 2001 16:51:11 -0400
Received: from [195.250.204.70] ([195.250.204.70]:19500 "EHLO raq.trendnet.si")
	by vger.kernel.org with ESMTP id <S261628AbRETUvF>;
	Sun, 20 May 2001 16:51:05 -0400
From: David Osojnik <dworf@siol.net>
Reply-To: dworf@siol.net
To: Andi Kleen <ak@suse.de>
Subject: Re: tcp_mem problem
Date: Sun, 20 May 2001 22:50:56 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <01052019331500.00946@cool> <20010520222610.A25477@gruyere.muc.suse.de>
In-Reply-To: <20010520222610.A25477@gruyere.muc.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01052022505600.05956@cool>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the system with problem is using kernel 2.4.2 on an P200 with 64mb ram. It 
> has about 20 users that use the box... (ftp, telnet, lynx, bitchx,...).
> 
> the problem is when the parameter tcp_mem HIGH gets exeded after about a 
day 
> of use! Then the box is going from the net and its not awailable. I tried 
to 
> tune the system with adding more in proc tcp_mem but the problem is still 
> there the box only lasts for bout 2h longer.
> 
> and i get this in messages
> 
> kernel: TCP: too many of orphaned sockets
> 
> It looks like my system is not droping closed sockets?


On Sunday 20 May 2001 22:26, you wrote:
>
> You can check by using netstat -tan
> Normally the message is harmless; when it happens the closed sockets are
> RST instead of being closed properly.
>
>
> -Andi

But why is the server going down when that message apheres in the log?... No 
one can telnet to the computer, ssh, web is not awailabe... And the message 
gets repeted all the time. The only thing to do is to reset the server.

Well I dont know what else to do.

netstat -tan doesnt show anything wrong.

David
