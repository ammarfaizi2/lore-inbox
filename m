Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272300AbTHSRQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHSROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:14:04 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:35973 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S274882AbTHSRMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:12:50 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 19:12:46 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@w.ods.org, richard@aspectgroup.co.uk, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819191246.027061dd.skraw@ithnet.com>
In-Reply-To: <20030819095302.7213ddd5.davem@redhat.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
	<20030819085717.56046afd.davem@redhat.com>
	<20030819185219.116fd259.skraw@ithnet.com>
	<20030819095302.7213ddd5.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 09:53:02 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Tue, 19 Aug 2003 18:52:19 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > On Tue, 19 Aug 2003 08:57:17 -0700
> > "David S. Miller" <davem@redhat.com> wrote:
> > 
> > > "Be liberal in what you accept, and conservative in what you send"
> > > -Jon Postel
> > 
> > If I understood what Richard said in this thread Jon just shot you
> > down. The conservative way to _request_ arp would definitely be to
> > request it from the "correct" subnet, because as a sender you ought
> > to give credit to knowing that "bad" boxes out there won't answer if
> > you do otherwise.
> 
> In the ARP request we are using the source address in the packet we
> are building for output.
> 
> If ARP doesn't work using that source address, we can only assume IP
> communication is not possible either.
> 
> It is the box not responding to this ARP which is preventing
> communication not the box creating the ARP request.

Please read my example from other email. Very simple to prove you wrong here.

Regards,
Stephan
