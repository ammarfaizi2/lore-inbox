Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbRFUDoz>; Wed, 20 Jun 2001 23:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264738AbRFUDop>; Wed, 20 Jun 2001 23:44:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33155 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264735AbRFUDoe>;
	Wed, 20 Jun 2001 23:44:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15153.28055.544280.527063@pizda.ninka.net>
Date: Wed, 20 Jun 2001 20:44:23 -0700 (PDT)
To: "Zack Weinberg" <zackw@stanford.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
In-Reply-To: <20010620202621.C12387@stanford.edu>
In-Reply-To: <20010620202621.C12387@stanford.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zack Weinberg writes:
 > Linus Torvalds wrote:
 > > And before you say "it has to return EFAULT", check the standards, and
 > > think about the case of libraries vs system calls - and how do you tell
 > > them apart?
 > 
 > My reading of the standard is that it has to either return EFAULT or
                                      ^^
 > raise SIGSEGV.  But I am not expert in XPG4-ese.

Linus is trying to point out: "what is this 'it'?"  Is it glibc or
what the kernel gives you?

 > Whether or not the standard requires anything, I would much rather
 > that the kernel not silently discard error conditions.

But only perhaps from a "quality of implementation" perspective not a
"correctness" one.

Later,
David S. Miller
davem@redhat.com

