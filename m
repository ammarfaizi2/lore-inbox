Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292876AbSBVOXy>; Fri, 22 Feb 2002 09:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292880AbSBVOXf>; Fri, 22 Feb 2002 09:23:35 -0500
Received: from host194.steeleye.com ([216.33.1.194]:5902 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292876AbSBVOXX>; Fri, 22 Feb 2002 09:23:23 -0500
Message-Id: <200202221423.g1MENIM02166@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.5] support for NCR voyager
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Feb 2002 09:23:18 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are only three changes over the last voyager patch

- merge the minor processor capabilites change from smpboot.c
- correct the configuration mess with VISW and MCA to make the file more 
readable
- Change the completion to a semaphore in voyager daemon (completions always 
wait in D which was causing a spurious increase in the load average).

The patch (153k) is available here

http://www.hansenpartnership.com/voyager/files/voyager-2.5.5.diff

James Bottomley

P.S. Just to clarify, the Voyager series are microchannel (MCA) SMP machines 
produced by NCR with model numbers 345x, 35xx, 4100 or 51xx.

