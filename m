Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTGHLRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGHLRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:17:34 -0400
Received: from tmi.comex.ru ([217.10.33.92]:1925 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S267192AbTGHLOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:14:50 -0400
X-Comment-To: Matthew Wilcox
To: Matthew Wilcox <willy@debian.org>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] parallel directory operations
From: bzzz@tmi.comex.ru
Date: Tue, 08 Jul 2003 15:29:07 +0000
In-Reply-To: <20030708112658.GJ23597@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Tue, 8 Jul 2003 12:26:58 +0100")
Message-ID: <87llv9ujek.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87wuetukpa.fsf@gw.home.net>
	<20030708112658.GJ23597@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Matthew Wilcox (MW) writes:

 MW> On Tue, Jul 08, 2003 at 03:01:05PM +0000, Alex Tomas wrote:
 >> I would to like to see any comments/suggestions.

 >> dynamic locks. supports exclusive and shared locks. exclusive lock may
 >> be taken several times by first owner.

 MW> Yuck.  It spins, it sleeps, it can be acquired recursively by the same
 MW> process.  Ugly stuff.

it allows to simplify rename case very much

