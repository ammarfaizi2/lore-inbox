Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSEGE5m>; Tue, 7 May 2002 00:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315339AbSEGE5l>; Tue, 7 May 2002 00:57:41 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:21458 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S315338AbSEGE5k>;
	Tue, 7 May 2002 00:57:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: modversion.h improvement suggestion 
In-Reply-To: Your message of "Mon, 06 May 2002 23:03:34 +0200."
             <E174pdv-0001rU-00@bigred.inka.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 May 2002 14:55:17 +1000
Message-ID: <23154.1020747317@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 May 2002 23:03:34 +0200, 
Olaf Titz <olaf@bigred.inka.de> wrote:
>i.e. copy the main Makefile, add a few rules to just echo the flags,
>and then invoke it in the original place (since it depends on that).
>We should really have a more elegant way to extract this info from the
>main Makefile.
>
>kaos wrote
>> In any case, modversions.h will disappear in kbuild 2.5.
>
>which leaves hope this issue will be addressed...

kbuild 2.5 has full and officially maintained support for compiling
code that is not yet in the main kernel tree.  No more hacks to get
external drivers, filesystems etc. to build.

