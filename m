Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbTHTOPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTHTOPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:15:23 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:44236 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261952AbTHTOPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:15:15 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 20 Aug 2003 16:15:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roman Pletka <rap@zurich.ibm.com>
Cc: bloemsaa@xs4all.nl, davem@redhat.com, alan@lxorguk.ukuu.org.uk,
       willy@w.ods.org, richard@aspectgroup.co.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030820161512.6ccdd963.skraw@ithnet.com>
In-Reply-To: <3F43362A.7090802@zurich.ibm.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
	<20030819085717.56046afd.davem@redhat.com>
	<20030819185219.116fd259.skraw@ithnet.com>
	<3F43362A.7090802@zurich.ibm.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 10:49:46 +0200
Roman Pletka <rap@zurich.ibm.com> wrote:

> Bas Bloemsaat wrote:
> >>Indeed, would people stop quoting from RFC 985 and
> >>RFC 826.
> > 
> > 
> > RFC 826 is referenced from 1009 as describing ARP. So in effect it does
> > define a standard.
> 
> RFC 1009 is obsolete too (by 1812 for the sake of completeness).
> Please stop quoting obsolete RFC's.
> 
> -- Roman

One of the big advantages of RFCs is that everybody can read them. In fact if
one names a special RFC for proving something he said, he should at least have
read it once:

<quote RFC 1812>
3.3.2 Address Resolution Protocol - ARP

   Routers that implement ARP MUST be compliant and SHOULD be
   unconditionally compliant with the requirements in [INTRO:2].

...

   INTRO:2.
        Internet Engineering Task Force (R. Braden, Editor),
        "Requirements for Internet Hosts - Communication Layers", STD 3,
        RFC 1122, USC/Information Sciences Institute, October 1989.

</quote>

=>

<qoute RFC 1122>
      2.3.2  Address Resolution Protocol -- ARP

         2.3.2.1  ARP Cache Validation

            An implementation of the Address Resolution Protocol (ARP)
            [LINK:2] MUST provide a mechanism to flush out-of-date cache
            entries.  If this mechanism involves a timeout, it SHOULD be
            possible to configure the timeout value.

...

[LINK:2] "An Ethernet Address Resolution Protocol," D. Plummer, RFC-826,
     November 1982.

</quote>

=>

RFC-826 is _valid_

Why do you think it is not valid, Roman? Where do you read that?

Regards,
Stephan
