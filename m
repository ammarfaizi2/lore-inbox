Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUAQGYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 01:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAQGYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 01:24:10 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:44241 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265632AbUAQGYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 01:24:08 -0500
Date: Fri, 16 Jan 2004 22:23:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Brad Tilley <bradtilley@usa.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible Bug in 2.4.24???]
Message-ID: <20040117062351.GU1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Oleg Drokin <green@linuxhacker.ru>,
	Brad Tilley <bradtilley@usa.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <514iaqBeC5488S07.1074301468@uwdvg007.cms.usa.net> <20040117051107.GC1967@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117051107.GC1967@linuxhacker.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 07:11:07AM +0200, Oleg Drokin wrote:
> Well, there was affect on filesystem - the write have failed.
> Also may be later that block was remapped, or that was internal drive's logic
> failure or something else like that.
> This journal block won't be used on subsequent mount (because transaction
> was not closed), but will be just
> overwritten. So even if its content was corrupted, reiserfs does not care.

I'd also suggest to brad that he replace the drive ASAP.

Mike
