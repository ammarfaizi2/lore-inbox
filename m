Return-Path: <linux-kernel-owner+w=401wt.eu-S1161046AbWLUADy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWLUADy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWLUADy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:03:54 -0500
Received: from tomts36.bellnexxia.net ([209.226.175.93]:40265 "EHLO
	tomts36-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161046AbWLUADx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:03:53 -0500
Date: Wed, 20 Dec 2006 19:03:51 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/9] atomic.h : standardising atomic primitives
Message-ID: <20061221000351.GF28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:02:21 up 119 days, 21:09,  6 users,  load average: 2.41, 1.50, 1.06
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It mainly adds support for missing 64 bits cmpxchg and 64 bits atomic add
unless. Therefore, principally 64 bits architectures are targeted by these
patches. It also adds the complete list of atomic operations on the atomic_long
type.

These patches applies on 2.6.20-rc1-git7.

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
