Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRKVVq4>; Thu, 22 Nov 2001 16:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281785AbRKVVqr>; Thu, 22 Nov 2001 16:46:47 -0500
Received: from sj1-3-1-20.iserver.com ([128.121.122.117]:29712 "EHLO
	sj1-3-1-20.iserver.com") by vger.kernel.org with ESMTP
	id <S276369AbRKVVqi>; Thu, 22 Nov 2001 16:46:38 -0500
Date: Thu, 22 Nov 2001 21:46:36 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] omnibus header cleanup
Message-ID: <20011122214636.A9790@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting advice...

Last week, I posted [1] patches ([2],[3]) to fix undisciplined macro 
definitions in 116 header files.  His Linusness has not picked them 
up, through several preN releases, nor commented.  I see four choices:

1. Keep posting the patches until they get picked up, or rot.

2. Split them up into four dozen separate patches, and pepper
   individual maintainers and Linus with them all, and check which 
   ones get in and which don't, and re-send the latter until they're
   all in.

3. Conclude that Linux maintainers are only interested in fixing 
   immediate causes of bugs that have already been reported.

4. Find some credible people willing to scan through the patches and 
   certify to Linus that they are Safe, Effective, and Not Destabilizing.

Choice (1) is hopeless.  (I have updated the patches for 2.4.15-pre9; 
the proposals for include/linux/pci.h had been picked up.)  Since 
choice (2) is about a hundred times as much work as I've already done 
on them, all of it administrative overhead, any sane person would 
choose (3) over (2).  

That leaves (4).  Who will scan one or both patches and certify them
for Linus?

There are certainly dozens of more-subtle bug sources (e.g. [4],[5]) in 
the kernel, and I would love to help smoke them out, but I can't afford 
to do that if it's a hundred times as much work to get the resulting 
patches accepted as to find and fix them in the first place.

Advice?  Certifiers?

Nathan Myers
ncm at cantrip dot org

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=100587948705950&w=2
[2] http://cantrip.org/omnibus-linux.diff
[3] http://cantrip.org/omnibus-includes.diff
[4] http://marc.theaimsgroup.com/?l=linux-kernel&m=100591078621276&w=2
[5] http://marc.theaimsgroup.com/?l=linux-kernel&m=100633930427682&w=2

