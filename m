Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264129AbTCXGpQ>; Mon, 24 Mar 2003 01:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264130AbTCXGpQ>; Mon, 24 Mar 2003 01:45:16 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:8977 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264129AbTCXGpP>; Mon, 24 Mar 2003 01:45:15 -0500
Date: Mon, 24 Mar 2003 06:56:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Jeff Garzik <jgarzik@pobox.com>, James Bourne <jbourne@mtroyal.ab.ca>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       Martin Mares <mj@ucw.cz>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324065616.B15528@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
	Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
	Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
	arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
References: <1240000.1048460079@[10.10.2.4]> <200303232319.h2NNJqs13257@devserv.devel.redhat.com> <20030324033505.GJ1449@x30.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030324033505.GJ1449@x30.local>; from andrea@suse.de on Sun, Mar 23, 2003 at 10:35:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 10:35:05PM -0500, Andrea Arcangeli wrote:
> very controversial. Andrew blessed them too, when he splitted them (he
> only giveup on the "-rest" patch so that one is still very monolithic
> sorry ;).

For the -rest stuff (and very few other split patches) there's still no
evidence that it needs to go into mainline.  But having the other stuff
in would certainly help to not only make mainline useable under higher loads
on not-lowend heardware and has the additional benefit that later patches
form -aa might just apply instead of people like me needing to spend some
time on merging them over just to not get them applied anyway..

