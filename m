Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVAaPOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVAaPOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVAaPOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:14:22 -0500
Received: from 80.178.38.121.forward.012.net.il ([80.178.38.121]:48617 "EHLO
	linux15") by vger.kernel.org with ESMTP id S261230AbVAaPOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:14:19 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: Pipes and fd question. Large amounts of data.
Date: Mon, 31 Jan 2005 17:14:08 +0200
User-Agent: KMail/1.7.1
Cc: Miles Sabin <miles@milessabin.com>, linux-kernel@vger.kernel.org
References: <200501301115.59532.ods15@ods15.dyndns.org> <200501301248.45538.ods15@ods15.dyndns.org> <41FE4876.8020507@nortelnetworks.com>
In-Reply-To: <41FE4876.8020507@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501311714.08672.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 January 2005 17:02, Chris Friesen wrote:
> Your other option would be to use processes with shared memory (either
> sysV or memory-mapped files).  This gets you the speed of shared memory
> maps, but also lets you get the reliability of not sharing your entire
> memory space.
>
> If you use NPTL, your locking should be quick as well.  If not, you can
> always roll your own futex-based locking.

To be honest, most of that was gibrish to me (NTPL, futex, sysV..).. Most of 
my experience with system calls is with pipes and files, I know very little 
about these other things...
Either way, you are a bit late, just half an hour ago, I have completed my 
program, and it works. :) I finished the pthread instead of select() 
implementation pretty quickly (now I understand why lazy programmers use 
threads.. heh), what took me so long was troubles with the 2 other programs, 
had to refine their command line params carefully...
(btw, the 2 other programs - MPlayer and MEncoder, and my job was transferring 
video AND audio between them.)

Thankyou for the reply,
- ods15
