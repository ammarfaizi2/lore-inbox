Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbVJRX3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVJRX3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVJRX3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:29:04 -0400
Received: from holomorphy.com ([66.93.40.71]:30133 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751488AbVJRX3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:29:02 -0400
Date: Tue, 18 Oct 2005 16:28:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robin Holt <holt@sgi.com>
Cc: Greg KH <greg@kroah.com>, linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051018232824.GQ29402@holomorphy.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com> <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com> <20051017113131.GA30898@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017113131.GA30898@lnx-holt.americas.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 06:31:31AM -0500, Robin Holt wrote:
> Not sure why it would fall that way.  Looking at the directory,
> I get:
> [holt@lnx-holt mm]$ grep -c 'EXPORT_SYMBOL(' *.c | egrep -v ":0$"
[...]
> I will happily change it, but that seems inconsistent with the
> majority of the exports from that subsystem.

I'm a bit more laissez-faire on this: I don't mind the export either
way. That said, I'm aware that the prevailing opinion is in favor of
EXPORT_SYMBOL_GPL().


-- wli
