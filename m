Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272338AbTHSRmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272327AbTHSRmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:42:06 -0400
Received: from gate.in-addr.de ([212.8.193.158]:20613 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S272342AbTHSRkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:40:41 -0400
Date: Tue, 19 Aug 2003 19:39:20 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "David S. Miller" <davem@redhat.com>, Bas Bloemsaat <bloemsaa@xs4all.nl>
Cc: richard@aspectgroup.co.uk, skraw@ithnet.com, willy@w.ods.org,
       alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030819173920.GA3301@marowsky-bree.de>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk> <070c01c36653$7f3c1ab0$c801a8c0@llewella> <20030819083438.26c985b9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030819083438.26c985b9.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-08-19T08:34:38,
   "David S. Miller" <davem@redhat.com> said:

> There are two valid ways the RFCs allow systems to handle
> IP addresses.
> 
> 1) IP addresses are owned by "the host"
> 2) IP addresses are owned by "the interface"
> 
> Linux does #1, many systems do #2, both are correct.

Yes, both are "correct" in the sense that the RFC allows this
interpretation. The _sensible_ interpretation for practical networking
however is #2, and the only persons who seem to believe differently are
those in charge of the Linux network code...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett

