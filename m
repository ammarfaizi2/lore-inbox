Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSEDMLQ>; Sat, 4 May 2002 08:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSEDMLQ>; Sat, 4 May 2002 08:11:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:19217 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312558AbSEDMLP>;
	Sat, 4 May 2002 08:11:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4 
In-Reply-To: Your message of "Sat, 04 May 2002 13:26:48 +0200."
             <Pine.LNX.4.44.0205041322080.12156-100000@netfinity.realnet.co.sz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 22:11:05 +1000
Message-ID: <23974.1020514265@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002 13:26:48 +0200 (SAST), 
Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
>	Just a minor nit, could you change the rm parameter to have -r 
>too? I've found that ^C halfway through a make can leave some old 
>directories (.tmp_include or somesuch).

You will have to provide more details of the problem that you think you
are seeing.  The .tmp_include files are part of the infrastructure that
lets me separate source and object trees, they are meant to be there.
make -f Makefile-2.5 mrproper deletes .tmp_include.

