Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbSK3SgH>; Sat, 30 Nov 2002 13:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267283AbSK3SgH>; Sat, 30 Nov 2002 13:36:07 -0500
Received: from ns.suse.de ([213.95.15.193]:23312 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267282AbSK3SgG>;
	Sat, 30 Nov 2002 13:36:06 -0500
To: Colin Slater <hoho@tacomeat.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs broken in 2.5.50 (possibly nanosecond stat timefields?)
References: <20021130.104556.59462872.hoho@tacomeat.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Nov 2002 19:43:31 +0100
In-Reply-To: Colin Slater's message of "30 Nov 2002 17:07:06 +0100"
Message-ID: <p73el92ucdo.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Slater <hoho@tacomeat.net> writes:

> ld.so? My systems is completely reiserfs (3.6), and nothing has
> changed in my config file between 2.5.47 and 2.5.50. Upon looking
> through the source tree, it seems like lines 1134-7 in

I just tested it and reiserfs works fine here with 2.5.50 with some
simple stress tests.

Are you sure you loaded the right modules? The new modutils don't 
do any kernel version checking anymore.

-Andi
