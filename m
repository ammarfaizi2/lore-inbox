Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290033AbSAKRcN>; Fri, 11 Jan 2002 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290034AbSAKRcD>; Fri, 11 Jan 2002 12:32:03 -0500
Received: from web20505.mail.yahoo.com ([216.136.226.140]:57361 "HELO
	web20505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290033AbSAKRbx>; Fri, 11 Jan 2002 12:31:53 -0500
Message-ID: <20020111173148.11811.qmail@web20505.mail.yahoo.com>
Date: Fri, 11 Jan 2002 18:31:48 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Loop-back block device?
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [here the partitions on the (latter) /dev/hda will
show
> up and - after this - mount the partitions. 

Although you can't do that at the moment, at least you
can
play with the loop offset when mounting your file as a
loopback to access a given partition. I think it would
be
simpler to write a small prog that will seek on your
file to
read the MBR and extended partitions and returns a
list
of offsets for all the partitions so that you can
mount them.
(man 8 mount for more info).

Regards,
Willy



___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
