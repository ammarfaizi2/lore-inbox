Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUHIQZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUHIQZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUHIQZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:25:58 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:54249 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266695AbUHIQZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:25:57 -0400
Date: Mon, 9 Aug 2004 12:25:56 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Paul Jackson <pj@sgi.com>
cc: =?ISO-8859-1?Q?Mari=E1n?= Tomko <macros@lmxmail.sk>,
       linux-kernel@vger.kernel.org
Subject: Re: howto apply supermount patch only....
In-Reply-To: <20040809062127.46acc804.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0408091224040.8693@vivaldi.madbase.net>
References: <411734E1.5070508@lmxmail.sk> <411734E1.5070508@lmxmail.sk>
 <20040809062127.46acc804.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Paul Jackson wrote:
> > patch: **** Only garbage was found in the patch input.
>
> Usually this means that your patch file, supermount-ng204.diff in the
> case you describe, doesn't contain an actual, correctly formatted,
> patch.

Maybe your patch is gzipped? Some browsers strip the .gz extension but
forget to decompress the file, or vice versa.

Try "zcat ../supermount-ng204.diff | patch -p1"

Eric
