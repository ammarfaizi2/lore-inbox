Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVCVRu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVCVRu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVCVRuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:50:25 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58603 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261478AbVCVRuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:50:17 -0500
Message-ID: <42405AD6.9010804@namesys.com>
Date: Tue, 22 Mar 2005 09:50:14 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de>
In-Reply-To: <20050322171340.GE1948@stusta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>Hi Hans,
>
>REISER4_FS is the only option with a dependency on !4KSTACKS which is 
>bad since 8 kB stacks on i386 won't stay forever.
>
>Could fix the problems with 4 kB stacks?
>
>Running
>
>  make checkstacks | grep reiser4
>
>inside te kernel sources after compiling gives you hints where problems 
>might come from.
>
>
>TIA
>Adrian
>
>  
>
All of my technical arguments on this topic were nicely obliterated by
Andrew.  The only real reason remaining (that I know of) is that I want
to first eliminate all things which are a barrier to inclusion before
dealing with this because it requires man hours to fix it.  If you want
to send us a cleanup patch that fixes it, I would be grateful for your
time donatioin.

Hans
