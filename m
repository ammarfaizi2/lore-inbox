Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269661AbUHZVS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbUHZVS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbUHZVPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:15:24 -0400
Received: from havoc.gtf.org ([216.162.42.101]:14235 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269642AbUHZVLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:11:14 -0400
Date: Thu, 26 Aug 2004 17:11:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: thomasz@hostmaster.org, linux-kernel@vger.kernel.org
Subject: Re: netfilter IPv6 support
Message-ID: <20040826211107.GA30080@havoc.gtf.org>
References: <1093546367.3497.23.camel@hostmaster.org> <412E4740.3090807@pobox.com> <20040826140637.336c4d10.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826140637.336c4d10.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:06:37PM -0700, David S. Miller wrote:
> On Thu, 26 Aug 2004 16:25:36 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > As Andi puts it, there is no infinite hash.
> 
> Using hash tables would be the problem :-)
> 
> Longest matching prefix lookup algorithms are a well researched area.
> One we have not taken advantage of much at all.  This is more than
> evident in our routing and netfilter code and I'm working to do
> something about it. :-)


Well, I interpreted Andi's statement as a more general complaint about
the overhead of per-connection resources involved in stateful
firewalling.

For example, a NAT box behind which 32,000 hosts sit, or something like
that :)

	Jeff



