Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318015AbSHHVls>; Thu, 8 Aug 2002 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHHVls>; Thu, 8 Aug 2002 17:41:48 -0400
Received: from holomorphy.com ([66.224.33.161]:23451 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318015AbSHHVlr>;
	Thu, 8 Aug 2002 17:41:47 -0400
Date: Thu, 8 Aug 2002 14:45:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Larson <plars@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, davej@suse.de, frankeh@us.ibm.com,
       andrea@suse.de
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020808214517.GH15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@zip.com.au>, Paul Larson <plars@austin.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, davej@suse.de,
	frankeh@us.ibm.com, andrea@suse.de
References: <3D51A7DD.A4F7C5E4@zip.com.au> <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 01:24:35PM -0700, Linus Torvalds wrote:
> Without that per-pid-count thing clarified, I don't think the (otherwise
> fairly straightforward) approach of Bills really flies.

I implemented the rest of it, based on maintaining hashtables for the
tgid, pgid, and sid as well as the pid itself. get_pid() was not the
focus of it.


Cheers,
Bill
