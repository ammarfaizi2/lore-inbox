Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTBIWBB>; Sun, 9 Feb 2003 17:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBIWBB>; Sun, 9 Feb 2003 17:01:01 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:55681 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S267457AbTBIWBA>; Sun, 9 Feb 2003 17:01:00 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Sun, 9 Feb 2003 15:10:44 -0700
To: linux-kernel@vger.kernel.org
Subject: Setjmp/Longjmp in the kernel?
Message-ID: <20030209221044.GA8761@morningstar.nowhere.lie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I ported an Object Oriented infrastructure to work with the Linux
kernel about two years ago.  For various reasons, that work was
dropped for a while.  Now, upon picking it back up again, there
are some new features that were not present in the original port
that I need to support.

Among these is a simple exception support system.  The core
of this system is based on the existence of a setjmp/longjmp
facility.  In digging through the source code, I've found a
few, architechturally specific implementations of such a
facility, but no generalized, multi-platform support.

A FAQ I found seems to suggest this deliberate, and that such
support will not ever be added to Linux.  Am I correct in
my understanding?  If so, is an architechturally specific
implementation (such as was done for ppc) acceptable?

Thanks,
John S.
