Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbTBVLgp>; Sat, 22 Feb 2003 06:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTBVLgp>; Sat, 22 Feb 2003 06:36:45 -0500
Received: from Mix-Lyon-107-2-213.abo.wanadoo.fr ([193.249.191.213]:49798 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S266967AbTBVLgo>;
	Sat, 22 Feb 2003 06:36:44 -0500
Subject: Re: ethernet-ATM-Router freezing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030222084958.GC23827@torres.ka0.zugschlus.de>
References: <20030222084958.GC23827@torres.ka0.zugschlus.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045914526.12534.153.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Feb 2003 12:48:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 09:49, Marc Haber wrote:

> These freezes occur on the machine actually doing the work. If I move
> the work to the other box, the freezes go with the work. Thus, I am
> pretty confident that this is not faulty hardware. I don't believe
> either that this is a incompatibility of the kernel since the systems
> in question have been working in this software configuration for two
> months before the problems started.

Your reasoning is wrong. It can well be a HW failure, those can be
load related in various way (memory failure happening when memory
is actually used, thermal failure happening on CPU load, etc...)

If the exact same setup worked for a while with same/similar loads
and suddenly started to fail, there are great chances it's actually
HW failure (possibly RAM).

Ben.

