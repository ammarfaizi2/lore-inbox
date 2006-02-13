Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWBMNWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWBMNWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWBMNWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:22:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43400
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932126AbWBMNWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:22:44 -0500
Subject: Re: [PATCH 03/13] hrtimer: rename ns to nsec
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.61.0602130209480.23808@scrub.home>
References: <Pine.LNX.4.61.0602130209480.23808@scrub.home>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:23:09 +0100
Message-Id: <1139836990.2480.473.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 02:09 +0100, Roman Zippel wrote:
> Currently we have two abbreviation for nanosecond, although ns may be
> more correct, nsec is already used rather widely (e.g. tv_nsec).
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

No strong feelings either way, but in general we want to keep names
short. There are other places in the kernel already using the _ns
variant, also we have the same with ms / msec.

We can certainly discuss a consolidation of all that, but its not in the
set of "minimally needed for 2.6.16".

	tglx


