Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSIWSGM>; Mon, 23 Sep 2002 14:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSIWSFL>; Mon, 23 Sep 2002 14:05:11 -0400
Received: from [195.39.17.254] ([195.39.17.254]:6016 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261274AbSIWSFJ>;
	Mon, 23 Sep 2002 14:05:09 -0400
Date: Sun, 22 Sep 2002 00:38:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.37 2/9: Trace driver
Message-ID: <20020922003837.A35@toy.ucw.cz>
References: <3D8CFD45.EA05DD5E@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D8CFD45.EA05DD5E@opersys.com>; from karim@opersys.com on Sat, Sep 21, 2002 at 07:14:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/*  Driver */
> +static int		sMajorNumber;		/* Major number of the tracer */
> +static int		sOpenCount;		/* Number of times device is open */
> +/*  Locking */

Why *s*OpenCount? Some creeping infection by hungarian notation?

									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

