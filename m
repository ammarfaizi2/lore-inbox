Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSGCRl0>; Wed, 3 Jul 2002 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSGCRlZ>; Wed, 3 Jul 2002 13:41:25 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:20741 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317107AbSGCRlZ>; Wed, 3 Jul 2002 13:41:25 -0400
Date: Wed, 3 Jul 2002 19:43:40 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: khromy <khromy@lnuxlab.ath.cx>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703174340.GL22762@louise.pinerecords.com>
References: <20020703022051.GA2669@lnuxlab.ath.cx> <3D226E86.695D27F3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D226E86.695D27F3@zip.com.au>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 29 days, 3:34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2 minutes.
> > When I copy the same file to /usr/local/, sync returns almost right away.
> 
> Gad.  Please, mount those filesystems as ext2 and retest.

Checking out $(smartctl -l /dev/hda) might be advisable too.

T.
