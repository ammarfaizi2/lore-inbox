Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUAEJTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 04:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUAEJTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 04:19:07 -0500
Received: from mail.mediaways.net ([193.189.224.113]:53612 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262792AbUAEJTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 04:19:05 -0500
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
Message-Id: <1073294318.3247.80.camel@localhost>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 10:18:39 +0100
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

yes indeed, judging from the cat source it does chose optimal buffer
size, here 1024 byte... so it reads/writes larger chunks... and jump
scrolling takes place...

Hmmhh,
Soeren

