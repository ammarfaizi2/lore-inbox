Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSFJXC7>; Mon, 10 Jun 2002 19:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFJXC6>; Mon, 10 Jun 2002 19:02:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:30217 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316499AbSFJXC5>;
	Mon, 10 Jun 2002 19:02:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas 
In-Reply-To: Your message of "Sun, 09 Jun 2002 17:58:04 +0100."
             <20020609175804.B8761@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 09:02:45 +1000
Message-ID: <5896.1023750165@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2002 17:58:04 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>With the latest kbuild version in 2.5.21, we are unable to build the
>following files:
>
>linux/drivers/block/smart1,2.h
>linux/drivers/scsi/53c7,8xx.c
>linux/drivers/scsi/53c7,8xx.h
>linux/drivers/scsi/53c7,8xx.scr
>linux/arch/arm/mm/proc-arm6,7.S
>linux/arch/arm/mm/proc-arm2,3.S

kbuild 2.5 can handle filenames with ',' in the name.  I do not believe
in restricting what users can do unless there is absolutely no
alternative.  In this case a smarter build system can handle special
filenames.

