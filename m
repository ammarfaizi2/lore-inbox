Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUHQUwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUHQUwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUHQUwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:52:39 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:19380 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266717AbUHQUwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:52:37 -0400
Message-ID: <2a4f155d040817135275c42157@mail.gmail.com>
Date: Tue, 17 Aug 2004 23:52:34 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Paul Fulghum <paulkf@microgate.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.de
In-Reply-To: <41226512.9000405@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com> <41226512.9000405@microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Andrew too.

On Tue, 17 Aug 2004 15:05:38 -0500, Paul Fulghum <paulkf@microgate.com> wrote:
> This is almost certainly related to the addition
> of pty devices to devfs in bk-driver-core.patch
> Change is by olh@suse.de
> 
> This explains why you are seein pty major devices
> created in a /dev/tty directory.
> 
> Specifically the changes in drivers/char/tty_io.c
> in function tty_register_device()
> 
> Try backing out that specific portion of bk-driver-core.patch

Backed out whole bk-driver-core.patch and everything works as
expected. Thanks for help.

Cheers,
ismail

-- 
Time is what you make of it
