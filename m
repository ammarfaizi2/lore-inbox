Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315237AbSEKXNX>; Sat, 11 May 2002 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSEKXNW>; Sat, 11 May 2002 19:13:22 -0400
Received: from codepoet.org ([166.70.14.212]:54185 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315237AbSEKXNW>;
	Sat, 11 May 2002 19:13:22 -0400
Date: Sat, 11 May 2002 17:13:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Meininger <jeffm@boxybutgood.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mapping from scsi Host/Chan/Id/Lun to /dev/foo
Message-ID: <20020511231324.GA3986@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Meininger <jeffm@boxybutgood.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205111609070.2589-100000@spaz.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat May 11, 2002 at 04:23:03PM -0500, Jeff Meininger wrote:
> 
> I'm trying to write a userspace program that takes Host/Chan/Id/Lun
> arguments for some sort of scsi storage device and prints out the
> corresponding /dev entry, if one exists.

Grab a copy of sg3-utils and read show_devices() in sginfo.c

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
