Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSGNJDr>; Sun, 14 Jul 2002 05:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSGNJDq>; Sun, 14 Jul 2002 05:03:46 -0400
Received: from 62-190-200-46.pdu.pipex.net ([62.190.200.46]:1028 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S314396AbSGNJDp>; Sun, 14 Jul 2002 05:03:45 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207140911.KAA00157@darkstar.example.net>
Subject: Re: IDE/ATAPI in 2.5
To: paul@paulbristow.net (Paul Bristow)
Date: Sun, 14 Jul 2002 10:11:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D313412.1030102@paulbristow.net> from "Paul Bristow" at Jul 14, 2002 10:19:30 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I much prefer Linus's suggestion of agreeing on the top level API.  I 
> would like to see disks, and removeable media having a single unified 
> namespace and set of ioctls so that the different user-space programs 
> don't need to worry about if they are dealing with a SCSI, PPA, 
> ATAPI-ish, USB, 1394 or whatever comes next drive.  Is that work? yes, 
> but it's also about communication and keeping things in the appropriate 
> place.  Let me hide the horrible things ide-floppy has to do from 
> user-space, and if that means I/we have to completely re-write the 
> ioctls etc so be it.  

I totally agree, why pick an arbitrary interface, and call it the 'standard', you might as well define your own standard, which suits the needs of supporting all future interfaces, (in the near future, anyway).

John.
