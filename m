Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318126AbSGWQdU>; Tue, 23 Jul 2002 12:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSGWQdT>; Tue, 23 Jul 2002 12:33:19 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:13580 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318126AbSGWQdT>; Tue, 23 Jul 2002 12:33:19 -0400
Date: Tue, 23 Jul 2002 17:36:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
Message-ID: <20020723173623.A25350@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Tue, Jul 23, 2002 at 09:28:26PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:28:26PM +1000, Neil Brown wrote:
> So... I have created "generic_out_cast" which is like the old
> list_entry but with an extra type arguement.  I have then
> changed uses of list_entry that did not actually apply to lists to use
> generic_out_cast, often indirectly.

Two small nitpicks:
* the name is silly.  what about get_container()?
* please move it away from list.h to e.g. kernel.h

