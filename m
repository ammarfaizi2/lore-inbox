Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135576AbREDBjG>; Thu, 3 May 2001 21:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbREDBiq>; Thu, 3 May 2001 21:38:46 -0400
Received: from 64-166-90-2.ded.pacbell.net ([64.166.90.2]:51439 "EHLO
	atheros.com") by vger.kernel.org with ESMTP id <S135576AbREDBid>;
	Thu, 3 May 2001 21:38:33 -0400
From: Jeffrey Kuskin <jsk@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15090.2067.861480.564724@byte.users.atheros.com>
Date: Thu, 3 May 2001 18:38:27 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.4+fork patch still sluggish
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically a followup to the "2.4.4 sluggish under fork load"
thread.

I am using Redhat 7.1 on a 128MB 400 MHz PII system.  I have a
locally-built 2.4.4 kernel to which I manually applied the patch that backs
out the child-before-parent behavior on a fork.  Namely, this patch:

  <http://boudicca.tux.org/hypermail/linux-kernel/2001week17/1288.html>

However, even with this patch applied, I still see extremley jerky mouse
pointer behavior when I run any kind of job that does lots of forking.  For
example, a kernel compile or even just the "configure" in preparation for
compiling XEmacs.

The same behavior, on exactly the same machine, did _not_ occur with Redhat
6.2/kernel 2.2.19.

I see that this patch has recently been merged into 2.4.5-pre1, but I am
concerned that it does actually fix the underlying problem.

Do others continue to see "jerky mouse pointer" behavior even with this
patch installed, or should I look for other causes?  For instance, are
there known problems with jerky mouse pointer behavior under heavy swapping
load?

-- 
Jeffrey Kuskin                              Tel: +1-408-773-5256
Senior System Engineer                      Fax: +1-408-773-9940
Atheros Communications                      http://www.atheros.com
jsk@atheros.com

