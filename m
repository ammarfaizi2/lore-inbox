Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278312AbRJMPIj>; Sat, 13 Oct 2001 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278313AbRJMPI3>; Sat, 13 Oct 2001 11:08:29 -0400
Received: from pigpen.lucentctc.com ([199.93.237.4]:30215 "EHLO
	pigpen.lucentctc.com") by vger.kernel.org with ESMTP
	id <S278312AbRJMPIY>; Sat, 13 Oct 2001 11:08:24 -0400
Message-ID: <CCE8403B91E4D4119E9300A0C9DDA22401C16AFD@pigpen.lucentctc.com>
From: "Kingsbury, Michael" <mkingsbury@avayactc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: High Rate of Sockets ->  No buffer space availible errors
Date: Sat, 13 Oct 2001 11:08:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a network testing application that is opening & closing sockets with
other machines at a high rate (multi-threaded,  1000 opens & closes a second
with ~20 machines.)  There's a seperate thread per machine its connecting
to, and each thread opens a socket, transmits 8k, and closes. 

The problem lies with an error of 'No buffer space availible' within the
first couple of seconds.  I've tried the SO_SNDBUF&  SO_RVCBUF, but that
doesn't make sense in my head anyways.  Anyone seen problems like this under
similar conditions & maybe any remedys?

-mike 
