Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277329AbRJJRUe>; Wed, 10 Oct 2001 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277330AbRJJRUS>; Wed, 10 Oct 2001 13:20:18 -0400
Received: from web21110.mail.yahoo.com ([216.136.227.112]:15389 "HELO
	web21110.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277329AbRJJRT7>; Wed, 10 Oct 2001 13:19:59 -0400
Message-ID: <20011010172030.93110.qmail@web21110.mail.yahoo.com>
Date: Wed, 10 Oct 2001 10:20:30 -0700 (PDT)
From: murali venkateshaiah <mvenkat_ml@yahoo.com>
Subject: Reverse RPCGEN? or other such tool?
To: linux-kernel@vger.kernel.org
Cc: mvenkat_ml@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

RPCs go with a tool, called rpcgen. It takes data
definition (of data structures) in a C-like
(RPCL)language and rpcgen converts it into standard
C-representation of the data. Its takes a .x file
and converts into .h file plus a _client.c,  _server.c
and _xdr.c files.

Now, I am looking for a tool that does the following
automation. It should take in C datastructures
(simplified representations of data definitions
where there are no embedded pointers but flat
representation), and spit out a rpcgen-able .x file.
Basically, a reverse rpcgen.

The capability makes it easier to program only
in C and not worry about the mode of transport.
It could be RPC or Corba or anything else.
C-definitions can be seamlessly converted to
RPC language or Corba etc

Am not sure IF there are any tools that SUN has
packaged with ONC-RPC or Ti-RPC. If anyone has more
information or pointers to other mailing lists please
email me directly. I'll summarise and repost.

Thanks
-Murali


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
