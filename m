Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbTBYSqO>; Tue, 25 Feb 2003 13:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268238AbTBYSqO>; Tue, 25 Feb 2003 13:46:14 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:18098 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268233AbTBYSqN>; Tue, 25 Feb 2003 13:46:13 -0500
Date: Tue, 25 Feb 2003 18:54:01 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225195339.GA31317@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <mbligh@aracnet.com> <200302251711.h1PHBct16624@mail.osdl.org> <b3g9mn$27s$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3g9mn$27s$1@penguin.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 05:38:31PM +0000, Linus Torvalds wrote:

 > Yes, if you don't take advantage of sysenter, then all the sysenter
 > support will just make us look worse ;(

Andi's patch[1] to remove one of the wrmsr's from the context switch
fast path should win back at least some of the lost microbenchmark
points.  (Full info at http://bugzilla.kernel.org/show_bug.cgi?id=350)

		Dave

[1] http://bugzilla.kernel.org/attachment.cgi?id=140&action=view

