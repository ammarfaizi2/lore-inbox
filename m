Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTICNEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTICNEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:04:12 -0400
Received: from drn-c-ae51.adsl.wanadoo.nl ([81.68.204.81]:177 "HELO moratar")
	by vger.kernel.org with SMTP id S262120AbTICNEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:04:06 -0400
From: Vladimir Lazarenko <vlad@lazarenko.net>
Organization: Favoretti Spagettolino Inc
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 15:04:03 +0200
User-Agent: KMail/1.5.9
Cc: adq_dvb@lidskialf.net, rl@hellgate.ch, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
References: <20030903080852.GA27649@k3.hellgate.ch> <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk> <20030903145356.35b9a192.skraw@ithnet.com>
In-Reply-To: <20030903145356.35b9a192.skraw@ithnet.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309031504.03596.vlad@lazarenko.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my board, A7V8X, ACPI/APIC works just perfectly with 2.4.22 and KT400 
chipset, alas on A7N8X Deluxe board with nForce2 chipsets it causes nasty 
hangups.
Machine just simply freezes, no oops, nothing whatsoever.

Disabling APIC solved the problem.

--
Regards,
Vladimir

On Wednesday 03 September 2003 14:53, Stephan von Krawczynski wrote:
> On Wed, 03 Sep 2003 12:40:06 +0100
>
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> > > 2.4.22 has the ACPI from 2.6 backported into it, (which includes my
> > > patch for nforce2 boards) so it will start having the same issue with
> > > the BIOS bug in KT333/KT400  boards.
> >
> > It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
> > basically unusable on anything I own thats not intel.
>
> I can't back that. At least on all my Serverworks boxes there are no
> problems with ACPI. I got reports from VIA-bases SMP boards that they are
> doing well, too. (all for 2.4.22)
>
> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Best regards,
Vladimir Lazarenko
