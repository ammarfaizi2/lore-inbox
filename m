Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUEEKeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUEEKeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 06:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUEEKeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 06:34:31 -0400
Received: from firewall.conet.cz ([213.175.54.250]:16834 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S264505AbUEEKea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 06:34:30 -0400
Date: Wed, 5 May 2004 12:34:20 +0200
From: Libor Vanek <libor@conet.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
Message-ID: <20040505103420.GA7174@Loki>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki> <Pine.LNX.4.53.0405040947070.13706@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0405040947070.13706@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 09:49:06AM -0400, Richard B. Johnson wrote:
> On Tue, 4 May 2004, Libor Vanek wrote:
> 
> [SNIPPED...all]
> 
> Did you catch this information? If all you want to do is to
> make a new version of a file, owned by the person who accesses the file
> (like VAX/VMS), then you trap open with O_RDWR or O_CREAT or O_TRUNC
> and make a copy with a numeral appended like: filename.typ;2.

Something like this (only make this copy in another directory)

> You do this by making a shared object that does what you want.
> The total affect upon user-mode code is a delayed (slow) open().

Yeah - I'm now studying how to communicate between kernel and user space (can't find out how to send data FROM ks TO us). What did you mean by "shared object"?

-- 

Libor Vanek
