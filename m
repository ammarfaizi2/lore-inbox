Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316958AbSFFMVO>; Thu, 6 Jun 2002 08:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSFFMVN>; Thu, 6 Jun 2002 08:21:13 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:23549 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316958AbSFFMVN>; Thu, 6 Jun 2002 08:21:13 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020605134945.7ad22093.kristian.peters@korseby.net> 
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -ac series won't compile without fix 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 13:21:13 +0100
Message-ID: <30073.1023366073@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kristian.peters@korseby.net said:
> I'm unable to compile the -ac series correctly.  A "make mrproper"
> does not help here.

> make[1]: *** No rule to make target `/usr/src/linux-2.4.19-pre10-ac1/fs/inflate_fs/infblock.h', needed by `/usr/src/linux-2.4.19-pre10-ac1/fs/inflate_fs/infcodes.h'.  Stop.

This is one of many symptoms of the broken kbuild system in current 2.4 and
2.5 kernels. You need to re-run 'make dep'.

--
dwmw2


