Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271701AbTHRMeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271703AbTHRMeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:34:07 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:55942 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271701AbTHRMeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:34:04 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 18 Aug 2003 14:34:01 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818143401.1352d158.skraw@ithnet.com>
In-Reply-To: <20030818044419.0bc24d14.davem@redhat.com>
References: <20030728213933.F81299@coredump.scriptkiddie.org>
	<200308171509570955.003E4FEC@192.168.128.16>
	<200308171516090038.0043F977@192.168.128.16>
	<1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	<200308171555280781.0067FB36@192.168.128.16>
	<1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	<200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817223118.3cbc497c.davem@redhat.com>
	<20030818133957.3d3d51d2.skraw@ithnet.com>
	<20030818044419.0bc24d14.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 04:44:19 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Mon, 18 Aug 2003 13:39:57 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > Can you please give us a striking example of a widespread application where
> > current behaviour is a requirement or at least a very positive thing?
> 
> [ I've been waiting what seems like centuries for someone
>   to even consider talking about source address selection,
>   alas I have to bring it up myself :( ]
> 
> I'll responsd by asking questions of you.

David, this is the wrong way round. Others'/my question was not about the
implementation and technical considerations leading to it (bottom up), but pure
and simple (and top down): what is the _positive_ outcome of this
implementation compared to others? We are always talking of setups that seem to
be more complicated because of the current situation. So one would expect that
there are advantages that make up the discussed disadvantages.
And since I obviously don't have the knowledge to see them, I'd like to learn
and therefore ask: what are the advantages on the _users_ side?

Regards,
Stephan
