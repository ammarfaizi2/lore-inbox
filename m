Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTGBU67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTGBU67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:58:59 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55566
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264535AbTGBU4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:56:36 -0400
Date: Wed, 2 Jul 2003 14:10:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <20030702211055.GC13296@matchmail.com>
Mail-Followup-To: Mel Gorman <mel@csn.ul.ie>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306262100.40707.phillips@arcor.de> <Pine.LNX.4.53.0306262030500.5910@skynet> <200306270222.27727.phillips@arcor.de> <Pine.LNX.4.53.0306271345330.14677@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306271345330.14677@skynet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 02:00:42PM +0100, Mel Gorman wrote:
> You're right, I will need to write a proper RFC one way or the other. I
> was thinking of using slabs because that way there wouldn't be need to
> scan all of mem_map, just a small number of slabs. I have no basis for
> this other than hand waving gestures though.

Mel,

This sounds much like something I was reading from Larry McVoy using page
objects (like one level higher in magnatude than pages).

I don't remember the URL, but there was something pretty extensive from
Larry already explaining the concept.
