Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310959AbSCHRNp>; Fri, 8 Mar 2002 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310960AbSCHRNg>; Fri, 8 Mar 2002 12:13:36 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:24329 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S310959AbSCHRNR>; Fri, 8 Mar 2002 12:13:17 -0500
Date: Fri, 8 Mar 2002 12:20:12 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: linux-kernel@vger.kernel.org
Subject: linux 2.4.18 fails to load static /sbin/init
Message-ID: <Pine.LNX.4.44.0203081218200.6974-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed this problem when trying to boot 2.4.18 on a Netra t1 200.
Basically what will happen is the kernel will mount / read-only, then try
to load /sbin/init, at which point it hangs.  If I a dynamically linked
wrapper around /sbin/init then all is happy and the system boots fine.

Any ideas or clues?

Regards,

Aaron

