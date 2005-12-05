Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVLEDJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVLEDJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 22:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVLEDJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 22:09:39 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:63278 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932302AbVLEDJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 22:09:39 -0500
Date: Sun, 4 Dec 2005 19:09:36 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205030936.GH15164@ca-server1.us.oracle.com>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org> <20051204142551.GB4769@merlin.emma.line.org> <1133707855.5188.41.camel@laptopd505.fenrus.org> <20051204150804.GA17846@merlin.emma.line.org> <jebqzw50x8.fsf@sykes.suse.de> <20051204161709.GC17846@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204161709.GC17846@merlin.emma.line.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 05:17:09PM +0100, Matthias Andree wrote:
> There are things that old Sun Workshop versions bitch about that GCC
> deals with without complaining, and I'm not talking about C99/C++-style
> comments. C standard issue? I believe not.

	I have seen many a code like so:

    char buf[4];
    memcpy(buf, source, 5);

accepted by the Sun compilers and run just fine.  When the application
was ported to Linux/GCC, the developers complained their program
segfaulted, and "it must be something broken on Linux!"
	Just because Sun's compiler does something doesn't mean it's
right :-)

Joel

-- 

Life's Little Instruction Book #510

	"Count your blessings."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
