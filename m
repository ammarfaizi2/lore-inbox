Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTEGVjC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTEGVjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:39:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16145 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264299AbTEGVi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:38:59 -0400
Date: Wed, 7 May 2003 23:54:30 +0200
To: "David S. Miller" <davem@redhat.com>
Cc: wli@holomorphy.com, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030507215430.GA1109@hh.idb.hist.no>
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507.064010.42794250.davem@redhat.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:40:10AM -0700, David S. Miller wrote:
>    From: William Lee Irwin III <wli@holomorphy.com>
>    Date: Wed, 7 May 2003 07:41:00 -0700
>    
>    In another thread, you mentioned that a certain netfilter cset had
>    issues; I think it might be good to add that as a second possible
>    cause.
> 
> Good point, Helge what netfilter stuff do you have in use?
> Are you doing NAT?

I have compiled in almost everything from netfilter, except
from "Amanda backup protocol support" and "NAT of local connections"

I also have ipv6 compiled, but no ipv6-netfilter.

I don't do any NAT.  I used to have some firewall rules, but not currently
as some previous dev-kernel broke on that.  So I have iptables
with no rules, just an ACCEPT policy for everything. I do no
routing either, only one network card is used.

Helge Hafting

