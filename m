Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291282AbSBMBcR>; Tue, 12 Feb 2002 20:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291284AbSBMBcG>; Tue, 12 Feb 2002 20:32:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26628 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291282AbSBMBb4>; Tue, 12 Feb 2002 20:31:56 -0500
Subject: Re: Quick question on Software RAID support.
To: inglem@cisco.com (Mukund Ingle)
Date: Wed, 13 Feb 2002 01:45:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.2.0.58.20020212172729.0195b630@bulkrate.cisco.com> from "Mukund Ingle" at Feb 12, 2002 05:34:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aoUH-0003mY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Does the Software RAID-5 support automatic detection
>      of a drive failure? How?

It sees the commands failing on the underlying controller. Set up a software
raid 5 and just yank a drive out of a  bay if you want to test it

> 2) Has Linux Software RAID-5 been used in the Enterprise environment
>      to support redundancy by any real-world networking company
>      or this is just a tool used by individuals to provide redundancy on
>      their own PCs in the labs and at home?

Dunno about that. I just hack code 8)
