Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135833AbRDTJMB>; Fri, 20 Apr 2001 05:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135834AbRDTJLv>; Fri, 20 Apr 2001 05:11:51 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:6414
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S135833AbRDTJLf>;
	Fri, 20 Apr 2001 05:11:35 -0400
Date: Fri, 20 Apr 2001 02:11:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
Message-ID: <20010420021133.I8578@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
	autofs@linux.kernel.org
In-Reply-To: <20010420014940.F8578@goop.org> <Pine.GSO.4.21.0104200457520.21455-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104200457520.21455-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Apr 20, 2001 at 05:00:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 05:00:04AM -0400, Alexander Viro wrote:
> Frankly, I'd rather add dput_locked() in dcache.c. The bug is real and
> since autofs4 is not the only place like that... I'll look into that
> stuff.

Sounds fine.

	J
