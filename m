Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVCPMmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVCPMmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVCPMmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:42:06 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:33732 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S262560AbVCPMmA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:42:00 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Umbrella-0.6 released
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 16 Mar 2005 13:42:07 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503161342.07498.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

---
Umbrella is a security mechanism that implements a combination of 
Process-Based Access Control (PBAC) and authentication of binaries through 
Digital Signed Binaries (DSB). The scheme is designed for Linux-based 
consumer electronic devices ranging from mobile phones to settop boxes.

Umbrella is implemented on top of the Linux Security Modules (LSM) framework. 
The PBAC scheme is enforced by a set of restrictions on each process. This 
policy is distributed with a binary in form of execute restrictions (attached 
in the binary) and within the program, where the developer has the 
opportunity of making a "restricted fork" for setting restrictions for new 
children.
---

We now present you with a new and cool version of Umbrella, namely
version 0.6. Besides fulfilling the roadmap of integration with GNU Privacy
Guard, the code has also been optimized and undertaken some major changes.

Followin is the main major changes:
  - Complete integration with GNU Privacy Guard to authenticate binaries
  - Hash tables for storing restrictions is replaced by the new, fast and
    simple FSR data structure, that mimics the 'dentry' structs in the
    kernel
  - The Umbrella system call is eliminated and completely replaced by a
    /proc filesystem interface
  - The Umbrella code is now completely independent of all architectures
    and kernel subversions

For instructions on how to try out the Process-Based Access Control and
Digitally Signed Binaries in Umbrella, please download the complete 0.6
tarball from SourceForge:
http://prdownloads.sourceforge.net/umbrella/umbrella-0.6.tar.bz2?download

Please refer to the README file in the tarball for further instructions.

As always we appreciate any comments, suggestions etc. you may have :-)


                                        Enjoy,
                                        The Umbrella Team.



-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
