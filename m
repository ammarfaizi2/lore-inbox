Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSJ1LAX>; Mon, 28 Oct 2002 06:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJ1LAX>; Mon, 28 Oct 2002 06:00:23 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:46562 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S263276AbSJ1K7o>; Mon, 28 Oct 2002 05:59:44 -0500
Message-ID: <3DBD1A11.2010301@drugphish.ch>
Date: Mon, 28 Oct 2002 12:05:53 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
Subject: Re: New csum and csum_copy routines - and a test/benchmark program
References: <200210280819.g9S8Jfp25782@Port.imtp.ilyichevsk.odessa.ua> <3DBCF9D0.4030602@drugphish.ch> <200210281034.g9SAYip26620@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Applied except for a bug ;) see below

Yes, this was wrong. I didn't read the code too closely. This introduced 
a wrong csum return for me. With your .4 version it works now perfectly.

> # as --version
> GNU assembler 2.13.90.0.6 20021002
> Copyright 2002 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License.  This program has absolutely no warranty.
> This assembler was configured for a target of `i386-pc-linux-gnu'.
> 
> What's yours?

# as --version
GNU assembler 2.11.92.0.10
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `i686-pc-linux-gnu'.

I reckon this explains it all. I'll go and upgrade the damn thing now.

Cheers,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

