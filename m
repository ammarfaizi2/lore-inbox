Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281413AbRKEWtc>; Mon, 5 Nov 2001 17:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281414AbRKEWtX>; Mon, 5 Nov 2001 17:49:23 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:61368 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281410AbRKEWtE>; Mon, 5 Nov 2001 17:49:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Mon, 5 Nov 2001 23:51:52 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva> <160qqc-1ClvWqC@fmrl04.sul.t-online.com> <3BE70B9A.1010904@candelatech.com>
In-Reply-To: <3BE70B9A.1010904@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160sXt-0LMrdQC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 November 2001 22:58, Ben Greear wrote:
> So if BNF makes it harder for shell scripts and sscanf, and harder for
> the kernel developers...what good does it do???  

You know how to parse the file. 
Take a look at /proc/partitions. Is its exact syntax obvious without 
examining the source in the kernel? Can it happen that there is a space or 
another unusual character in the device path and what happens then? Could it 
be that someone decides that an additional column is neccessary and how can 
my parser stay compatible then? Are there any suprises or special conditions 
that I don't know about? Maybe one of the fields is hexadecimal but I think 
it is decimal, I can't see it from looking at the file's content.

bye...
