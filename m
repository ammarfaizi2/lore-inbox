Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTIBCrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTIBCrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:47:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35264 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263431AbTIBCrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:47:15 -0400
Message-ID: <3F5404A4.4080700@pobox.com>
Date: Mon, 01 Sep 2003 22:47:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: dontdiff for 2.6.0-test4
References: <3F53F142.5050909@pobox.com> <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org> <20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com> <20030901171806.GB1041@mars.ravnborg.org> <7vk78rykzb.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vk78rykzb.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> I do not think it is a tangent.  While I am not opposed to ship
> dontdiff under Documentation/* separately from the current
> mrproper implementation in the Makefile, if these two should
> name the identical set of paths, coming up with a scheme in
> which humans have to maintain just a single source and derive
> these two different usage from that single source would make
> people's life easier.  Two things that should be identical but
> have to be kept in sync by hand is simply a maintenance
> headache.

The two are maintained separately now.  This is changing a file location 
to make things a bit more convenient for dontdiff users; it's not 
radically changing anything, technically or politically.

If there are persons that consider the presence of dontdiff in the tree 
a maintenance headache, then those persons should not patch dontdiif. 
Problem solved :)  It's a file that's not going change often.


> On the other hand, if there are paths that should be in dontdiff
> that should not be cleaned by mrprper, or vice versa, then
> keeping two separately and maintaining two independently would
> absolutely makes sense.  Are there such cases?

People are thinking _way_ too hard about this.  This is just plunking a 
rarely-changing file into the kernel tree.  Even implying some sort of 
maintenance hassle is making a mountain out of a molehill.

	Jeff



