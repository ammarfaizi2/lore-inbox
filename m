Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTKCQLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKCQLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:11:09 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:1976 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262078AbTKCQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:11:04 -0500
X-Sender-Authentication: net64
Date: Mon, 3 Nov 2003 17:11:01 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
Message-Id: <20031103171101.12b2cb59.skraw@ithnet.com>
In-Reply-To: <3FA677D7.1000100@portrix.net>
References: <3FA62DD4.1020202@portrix.net>
	<20031103110129.GF1772@x30.random>
	<3FA63A57.8070606@portrix.net>
	<20031103143656.GA6785@x30.random>
	<3FA677D7.1000100@portrix.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Nov 2003 16:44:23 +0100
Jan Dittmer <j.dittmer@portrix.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andrea Arcangeli wrote:
> | On Mon, Nov 03, 2003 at 12:21:59PM +0100, Jan Dittmer wrote:
> |
> |>I'll give it a try. Is there a way in 2.4-aa to get the two additional
> |>virtual processors displayed?
> |
> |
> | No idea why they're not displayed, they should. my HT 2-way xeon shows 4
> | cpus not 2 (with 2.4 too).
> 
> Strange, if I enable Highmem support and set CONFIG_NR_CPUS from 4 to 8,
> 4 penguins are showing up...
> 
> Jan

Have a look at /proc/cpuinfo. Possibly your processor numbers are not linear ...

Regards,
Stephan
