Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133111AbRDLM2m>; Thu, 12 Apr 2001 08:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133113AbRDLM2c>; Thu, 12 Apr 2001 08:28:32 -0400
Received: from fiji.cs.washington.edu ([128.95.8.16]:38802 "EHLO
	fiji.cs.washington.edu") by vger.kernel.org with ESMTP
	id <S133111AbRDLM2U>; Thu, 12 Apr 2001 08:28:20 -0400
Date: Thu, 12 Apr 2001 05:28:19 -0700 (PDT)
From: Albert Wong <awong@cs.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: include/linux/ghash.h
Message-ID: <Pine.LNX.4.21.0104120523350.29920-100000@fiji.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!  In kernel 2.4.3, I think I found a minor error in the file:

	include/linux/ghash.h

On line 109, it says:

	int ix = hashfn(pos);\

and it should say:

	int ix = HASHFN(pos);\

Out of curiosity, is there a reason that this hash table doesn't seem to
be used anywhere in the kernel?  I stumbled across it while writing some
code for my OS class project and later realized that it isn't being used
anywhere.  Should I be avoiding this file for some reason?

-Albert

------------

Sure Pikachu could kick Hello Kitty's @$$, but acts of jealousy don't
  change the fact that HK's cuter!

PGP Key and Fingerprint:
	http://www.cs.washington.edu/homes/awong/gnupgpkey.txt
	603F 118F 2B0E 47C6 9FCE  B0AA DA83 089D B120 6714

