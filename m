Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSDELB7>; Fri, 5 Apr 2002 06:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSDELBu>; Fri, 5 Apr 2002 06:01:50 -0500
Received: from ppp-217-133-225-223.dialup.tiscali.it ([217.133.225.223]:17165
	"EHLO server.kopspa.hn.org") by vger.kernel.org with ESMTP
	id <S310139AbSDELBg> convert rfc822-to-8bit; Fri, 5 Apr 2002 06:01:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Simone <kopspa@gmx.it>
To: linux-kernel@vger.kernel.org
Subject: problems with 2.4.*
Date: Fri, 5 Apr 2002 12:00:11 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204051200.11315.kopspa@gmx.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i'm writing you because i have a problem on a lot of boxes with the 2.4 
kernels.

I have a lot of zombie [defunct] procs .

when i launch for example a simple script that do

while :; do ls ; ps x ; lsmod ; pstree ; etc etc etc ; done

after abount an hour the script crash and a ps x output is

[ls <defunct>]
ecc

when procs is defunct the system became instable. gcc tell me 

error in /usr/bin/gcc:2328 and any programs tell me that i've not the ncurses 
libraries ecc 

if i boot my machine without /proc filesystem it's very stable :)

i've tryed 2.2 kernels and there is no problem

my boxes are P3 1000 with via apollo chipset / P4 1.5ghz with intel 845 
ide hard disks vga 32mb tnt2 and slackware 8 distro
i've the same problem with all the distros with 2.4 kernels

it's a big problem because i have a relaying mail server that defunct 
sendmail!

sorry for my english :) 
