Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUHGQRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUHGQRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUHGQRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:17:23 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:1255 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S263448AbUHGQRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:17:21 -0400
Date: Sat, 7 Aug 2004 12:17:17 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Program-invoking Symbolic Links?
In-Reply-To: <200408051504.26203.jmc@xisl.com>
Message-ID: <Pine.LNX.4.58.0408071208420.10018@vivaldi.madbase.net>
References: <200408051504.26203.jmc@xisl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Aug 2004, John M Collins wrote:
> latest_version.tar => "tar cf - /latest/and/greatest"
> latest_version.tgz => "gzip -c latest_version"

> Such a scheme would let you implement things like hit counts on web
> sites "for free" without you having to rush out and run a CGI
> program as at present.

So you think this is too much work:

#!/bin/sh
echo Content-Type: application/x-tar
echo
tar cf - /latest/and/greatest

Seems to me you found a solution in search of a problem.

Eric
