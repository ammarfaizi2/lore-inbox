Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUADXTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUADXTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:19:35 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:1970 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265765AbUADXTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:19:25 -0500
Date: Sun, 4 Jan 2004 15:18:55 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: something is leaking memory
Message-ID: <20040104231855.GU1882@matchmail.com>
Mail-Followup-To: Erik Hensema <erik@hensema.net>,
	linux-kernel@vger.kernel.org
References: <slrnbvgohn.1pb.erik@dexter.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnbvgohn.1pb.erik@dexter.hensema.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 06:57:59PM +0000, Erik Hensema wrote:
> The leak can be most easily seen in my rrdtool graphs of memory
> usage: http://dexter.hensema.net/~erik/stats/mem-mon.gif and
> http://dexter.hensema.net/~erik/stats/mem-year.gif - try to guess
> when I switched to 2.6.0-test11 ;-)

I saw something similair on my lrrd graphs.

http://www.matchmail.com/stats/lrrd/matchmail.com/mis-mike-wstn.matchmail.com-memory.html

But it also happens on 2.4.23, and it was a bug in rxvt which I won't be
able to try to reproduce until I get back to work tomorrow.

Mike
