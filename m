Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTAaC70>; Thu, 30 Jan 2003 21:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTAaC70>; Thu, 30 Jan 2003 21:59:26 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:5510 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267692AbTAaC70>;
	Thu, 30 Jan 2003 21:59:26 -0500
Date: Thu, 30 Jan 2003 22:10:30 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update PnP IDE (2/6)
Message-ID: <20030130221030.GG2246@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andre Hedrick <andre@linux-ide.org>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20030125201516.GA12794@neo.rr.com> <Pine.LNX.4.10.10301251824510.1744-100000@master.linux-ide.org> <20030129222632.GD2246@neo.rr.com> <1043926921.28133.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043926921.28133.19.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 11:42:01AM +0000, Alan Cox wrote:
> On Wed, 2003-01-29 at 22:26, Adam Belay wrote:
> > a mess when PnP hotplugging is finally used.  Also if a pnp protocol was presented
> > in a removable module format, the protocol may want drivers to detach from its
> > devices upon module unload.  Are there any other hotpluggable ide devices and if
> > so how are they handled?
> 
> The IDE layer does not currently handle hotplugging. It needs a lot of work
> before that can happen

Would you suggest I remove the ide_unregister and place a error message if that area
is ever called in the pnp ide driver or is it better to leave it in there?  I'd like
to get this patch out soon so users can take advantage of these changes.  Becuase
pnp does not currently support hotplugging, I doubt there will be any problems.

Thanks,
Adam
