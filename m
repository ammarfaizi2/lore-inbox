Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSFDLr5>; Tue, 4 Jun 2002 07:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSFDLpK>; Tue, 4 Jun 2002 07:45:10 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:6787 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317479AbSFDLox>; Tue, 4 Jun 2002 07:44:53 -0400
Date: Tue, 4 Jun 2002 13:44:44 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: bonganilinux@mweb.co.za
cc: Hossein Mobahi <hmobahi@yahoo.com>, linux-kernel@vger.kernel.org,
        linux-c-programming@vger.kernel.org
Subject: Re: problem with <asm/semaphore.h>
In-Reply-To: <E17FCaW-0002V9-00@rammstein.mweb.co.za>
Message-ID: <Pine.GSO.4.05.10206041343470.7705-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002 bonganilinux@mweb.co.za wrote:

> I think you a trying to include a file from the linux source
> which will not work for use-space apps. Try using 
> #include <semaphore.h> instead 

yes, sounds right, since struct semaphore in asm/semaphore will be
defined only if __KERNEL__ is defined.

	tm

-- 
in some way i do, and in some way i don't.

