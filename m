Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbSLELrm>; Thu, 5 Dec 2002 06:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbSLELrm>; Thu, 5 Dec 2002 06:47:42 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53253 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267287AbSLELrl>; Thu, 5 Dec 2002 06:47:41 -0500
Date: Thu, 5 Dec 2002 12:55:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021205115513.GD15405@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021204113419.GA20282@merlin.emma.line.org> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> <20021204183710.GA4004@merlin.emma.line.org> <E18JgHI-0006Gx-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18JgHI-0006Gx-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Dec 2002, Matthew Garrett wrote:

> See http://www.uni-ulm.de/~s_smasch/various/shebang/ . FreeBSD is the
> *only* OS to pass multiple arguments. SUS says nothing about it, and
> pretty much every single implementation varies. It does not work
> everywhere else.

Now that's a useful resource.

> File a bug against perlrun(1).

Hum, no. In fact, the offending line will work:

- on systems that only pass on the first argument or none at all
- on systems that split on whitespace
- on /bin/sh that silently ignore options starting with "-- "

So it's somewhat compatible already.
