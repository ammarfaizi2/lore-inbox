Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310858AbSCMRZm>; Wed, 13 Mar 2002 12:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310869AbSCMRZ0>; Wed, 13 Mar 2002 12:25:26 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10247 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310858AbSCMRYn>;
	Wed, 13 Mar 2002 12:24:43 -0500
Date: Wed, 13 Mar 2002 14:24:22 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [ANN] rmap VM kernel RPM
Message-ID: <Pine.LNX.4.44L.0203131413240.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

by popular request I've integrated -rmap into Conectiva's kernel
RPM so people who don't like kernel patching can still test the
-rmap VM easily.

The -rmap (reverse mapping) VM is an attempt to fix some of the
fundamental virtual memory management problems that have plagued
Linux since its introduction to larger machines and more complex
workloads.  It is an attempt at a more flexible and robust VM.

While little performance tuning and optimisation has been done
yet, people have found it to perform better than the standard
VM for various workloads.

This version of the kernel RPM with -rmap VM is based on 2.4.18
as shipped by Conectiva and the latest stable -rmap version 12 VM.

These kernel RPMS, with stable -rmap VM, are available from:

	http://nl.linux.org/pub/linux/conectiva/kernel-rmap/
	ftp://nl.linux.org/pub/linux/conectiva/kernel-rmap/


More experimental versions of the -rmap VM can be found on:

	http://surriel.com/patches/
	http://linuxvm.bkbit.net/


kind regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

