Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbTCNBdC>; Thu, 13 Mar 2003 20:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbTCNBdC>; Thu, 13 Mar 2003 20:33:02 -0500
Received: from cs.columbia.edu ([128.59.16.20]:58297 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S263206AbTCNBdB>;
	Thu, 13 Mar 2003 20:33:01 -0500
Subject: fork/sh/hello microbenchmark performance in chroot
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1047606184.10046.9.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 20:43:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to play with our a homebrew version of lmbench's fork
benchmark which exec's sh to run a "hello world" program.  On normal
2.4.18 (UP 933mhz p3) it runs in about .2s  However, within a chrooted
environment I'm looking at 1s.

Anyone knows why this runs significantly slower within a chroot?

thanks,

shaya

