Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbTLEW4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTLEW4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:56:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34486 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264592AbTLEW42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:56:28 -0500
Date: Fri, 5 Dec 2003 14:56:24 -0800
From: "David S. Miller" <davem@redhat.com>
To: Stephen Lee <mukansai@emailplus.org>
Cc: mukansai@emailplus.org, scott.feldman@intel.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-Id: <20031205145624.5810bb71.davem@redhat.com>
In-Reply-To: <20031206071129.D31D.MUKANSAI@emailplus.org>
References: <20031204213030.2B75.MUKANSAI@emailplus.org>
	<20031205122819.25ac14ab.davem@redhat.com>
	<20031206071129.D31D.MUKANSAI@emailplus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Dec 2003 07:20:09 +0900
Stephen Lee <mukansai@emailplus.org> wrote:

> "David S. Miller" <davem@redhat.com> wrote:
> > 
> > OK, I've found out what IP conntack does that creates the problems.
> > [...]
> > People can confirm this analysis by applying the patch below, enabling
> > TSO with conntrack loaded, and see if the problem goes away.
> 
> I tested it with both e1000 & tg3, TSO on, and it is working fine for me
> using ftp and scp.

Great, I'll push the fix to Linus.

Thanks.
