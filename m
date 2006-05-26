Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWEZOUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWEZOUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWEZOUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:20:51 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:47487 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S1750771AbWEZOUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:20:49 -0400
X-ME-UUID: 20060526142047106.19F691C0008F@mwinf1103.wanadoo.fr
Date: Fri, 26 May 2006 16:15:35 +0200
To: Mark Lord <liml@rtr.ca>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Jeff Garzik <jgarzik@pobox.com>,
       Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp c pl atform
Message-ID: <20060526141535.GA7084@powerlinux.fr>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca> <20060526114245.GA32330@powerlinux.fr> <44770065.8070907@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <44770065.8070907@rtr.ca>
User-Agent: Mutt/1.5.9i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2006 at 09:19:33AM -0400, Mark Lord wrote:
> Sven Luther wrote:
> >On Fri, May 26, 2006 at 07:41:24AM -0400, Mark Lord wrote:
> >>All of the relevant bits of "my work" are now in Jeff's upstream libata 
> >>tree,
> >>from the recently posted sata_mv patches.
> >
> >Ok. can i use this tree with a 2.6.16 base ?
> 
> Not as-is.  Here (attached) is a patch for 2.6.16.17+ that updates
> the sata_mv driver to the latest source.  Completely untested,
> but it does compile.
> 
> I will hopefully test it later today, but in the meanwhile, have a go at it.

And here is attached my dmesg output. The last bit of mv_host_intr was when i
tried to access the partition table of the disk with parted.

Friendly,

Sven Luther

--J2SCkAp4GZ/dPZZf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg-2.6.16-mv_sata.gz"
Content-Transfer-Encoding: base64

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
cmFhPAAA

--J2SCkAp4GZ/dPZZf--

