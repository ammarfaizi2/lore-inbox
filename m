Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSHKJf3>; Sun, 11 Aug 2002 05:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHKJf3>; Sun, 11 Aug 2002 05:35:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315285AbSHKJf1>;
	Sun, 11 Aug 2002 05:35:27 -0400
Message-ID: <3D563313.718CB02B@zip.com.au>
Date: Sun, 11 Aug 2002 02:49:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <20020810201027.E306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com> <20020811031705.GA13878@netnation.com> <3D55FF30.6164040D@zip.com.au> <20020811084652.GB22497@netnation.com> <3D563035.C6BA9F51@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> So if you use something with known geometry, like /dev/fd0h1440, it works!

No it doesn't.  You can run mke2fs, but the result is a wreck.
