Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUAEIkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 03:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUAEIkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 03:40:11 -0500
Received: from mail.mediaways.net ([193.189.224.113]:33638 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S265906AbUAEIkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 03:40:08 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, szonyi calin <caszonyi@yahoo.com>,
       azarah@nosferatu.za.org, Con Kolivas <kernel@kolivas.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <20040104234703.GY1882@matchmail.com>
References: <1073227359.6075.284.camel@nosferatu.lan>
	 <20040104225827.39142.qmail@web40613.mail.yahoo.com>
	 <20040104233312.GA649@alpha.home.local>
	 <20040104234703.GY1882@matchmail.com>
Content-Type: text/plain
Message-Id: <1073291940.8884.66.camel@localhost>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 09:39:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > at a time. I have yet to understand why 'ls|cat' behaves
> > differently, but fortunately it works and it has already saved
> > me some useful time.
> 
> cat probably does some buffering for you, and sends the output to xterm in
> larger blocks.

interestingly running ls on a remote machine in a directory with a
similiar amount of files (local xterm with ssh connection to that
machine) is also as fast as this ls | cat workaround...

Soeren

