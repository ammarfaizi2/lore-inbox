Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317104AbSFFTPN>; Thu, 6 Jun 2002 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSFFTPM>; Thu, 6 Jun 2002 15:15:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:264 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317104AbSFFTPL>; Thu, 6 Jun 2002 15:15:11 -0400
Date: Thu, 6 Jun 2002 21:15:03 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild-2.5 2.4.19-pre10-ac2 "automatic" make installable?
Message-ID: <20020606191503.GH17859@louise.pinerecords.com>
In-Reply-To: <000701c20d8a$7234b520$66aca8c0@kpfhome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 2 days, 7:11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <snip>?
> ... and renamed Makefile to Makefile-2.4 and Makefile-2.5 to
> Makefile (so I don't have to keep specifying -f Makefile-2.5).

You are not supposed to do this. The original Makefile gets grepped
for kernel version by kbuild 2.5. Your renaming the Makefiles is probably
the cause of the seemingly automated rebuild.

T.
