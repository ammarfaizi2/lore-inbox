Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRBUNSh>; Wed, 21 Feb 2001 08:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRBUNS1>; Wed, 21 Feb 2001 08:18:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29706 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129444AbRBUNSN>; Wed, 21 Feb 2001 08:18:13 -0500
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
To: mager@tzi.de (Markus Germeier)
Date: Wed, 21 Feb 2001 13:21:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <94ae7g9o8t.fsf@religion.informatik.uni-bremen.de> from "Markus Germeier" at Feb 21, 2001 02:09:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VZCs-00023R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> after upgrading to 2.2.19pre9 (+ 2 NFS-patches, IPv6 enabled) idle
> connections tend to shut down without a visible reason:

Yes I've seen this too. It seems that the tcp changes broke the keepalive 
handling somewhere when I leave a non Linux target idle.

Dave - any ideas, shall we back it out and work on it for 2.2.20 ?
