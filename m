Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275784AbRJFWCF>; Sat, 6 Oct 2001 18:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJFWBz>; Sat, 6 Oct 2001 18:01:55 -0400
Received: from mk-smarthost-1.mail.uk.worldonline.com ([212.74.112.71]:54798
	"EHLO mk-smarthost-1.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S275765AbRJFWBj>; Sat, 6 Oct 2001 18:01:39 -0400
To: linux-kernel@vger.kernel.org
From: <$}lkml.jrh{$@daria.co.uk (Jonathan R. Hudson)>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: VFS: brelse: Trying to free free buffer
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <41a3.3bbf7f68.48052@trespassersw.daria.co.uk>
Date: Sat, 06 Oct 2001 22:02:16 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last week, on a couple of machines running -ac{3,4,5,7},
reiserfs, I've noticed a number of 

kernel: VFS: brelse: Trying to free free buffer

in the syslog. Should I be concerned ? As far as I can see, there is
no pattern.

