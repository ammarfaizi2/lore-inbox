Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbRBPMtt>; Fri, 16 Feb 2001 07:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbRBPMtj>; Fri, 16 Feb 2001 07:49:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46863 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130466AbRBPMtg>; Fri, 16 Feb 2001 07:49:36 -0500
Subject: Re: mke2fs and kernel VM issues
To: tytso@valinux.com
Date: Fri, 16 Feb 2001 12:49:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, sflory@valinux.com, chip@valinux.com,
        linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <E14TkFk-0007Nz-00@beefcake.hdqt.valinux.com> from "tytso@valinux.com" at Feb 16, 2001 04:44:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TkKM-00034C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> case, for example, we saw it with a system that had "only" 256 megs of
> memory, and creating a 72 gigabyte filesystem using a 8x9gb RAID
> configuration.

Ok I've only tested 90Gb on 2.2.19pre3, not more than that

> workaround did fix IBM's problem, which lends credence to the theory
> that the problem is a VM bug related to a lack of sufficient write
> throttling.  

Yep. I think 2.4.1 is about the first kernel that gets this right



