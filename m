Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTGCWHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTGCWHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:07:45 -0400
Received: from holomorphy.com ([66.224.33.161]:58307 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265440AbTGCWHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:07:10 -0400
Date: Thu, 3 Jul 2003 15:21:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703222113.GS26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Jamie Lokier <jamie@shareable.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com> <20030702233014.GW23578@dualathlon.random> <20030702235540.GK26348@holomorphy.com> <20030703113144.GY23578@dualathlon.random> <20030703114626.GP26348@holomorphy.com> <20030703125839.GZ23578@dualathlon.random> <20030703184825.GA17090@mail.jlokier.co.uk> <20030703185431.GQ26348@holomorphy.com> <20030703193328.GN23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703193328.GN23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:54:31AM -0700, William Lee Irwin III wrote:
>> I call that application #2.

On Thu, Jul 03, 2003 at 09:33:28PM +0200, Andrea Arcangeli wrote:
> maybe I'm missing something but protections have nothing to do with
> remap_file_pages IMHO. That's all about teaching the swap code to
> reserve more bits in the swap entry and to store the protections there
> and possibly teaching the page fault not to get confused. It might
> prefer to use the populate callback too to avoid specializing the
> pte_none case, but I think the syscall should be different, and it
> shouldn't have anything to do with the nonlinearity (nor with rmap).

It's obvious what to do about protections.


-- wli
