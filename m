Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTEHB00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 21:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTEHB00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 21:26:26 -0400
Received: from holomorphy.com ([66.224.33.161]:53907 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264358AbTEHB0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 21:26:25 -0400
Date: Wed, 7 May 2003 18:38:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508013854.GW8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@digeo.com
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507215430.GA1109@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:40:10AM -0700, David S. Miller wrote:
>> Good point, Helge what netfilter stuff do you have in use?
>> Are you doing NAT?

On Wed, May 07, 2003 at 11:54:30PM +0200, Helge Hafting wrote:
> I have compiled in almost everything from netfilter, except
> from "Amanda backup protocol support" and "NAT of local connections"
> I also have ipv6 compiled, but no ipv6-netfilter.
> I don't do any NAT.  I used to have some firewall rules, but not currently
> as some previous dev-kernel broke on that.  So I have iptables
> with no rules, just an ACCEPT policy for everything. I do no
> routing either, only one network card is used.

Can you try one kernel with the netfilter cset backed out, and another
with the re-slabification patch backed out? (But not with both backed
out simultaneously).

Thanks.


-- wli
