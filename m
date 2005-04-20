Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVDTXM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVDTXM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVDTXM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:12:58 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:49964 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261835AbVDTXMl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:12:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kA9hUmnBSlm4j42ctiMTfKlG6lNLrhROd7Stfp2AlHpiZRPclUI48ON5jhOIj2T6YU0N/4+y3oCow3a8as3PGbne/cLsLhf8QhXHaaql1fOb4uldDGiQzXXRfVDTghSk/zZU9pSiNC1/wgRaAhQ+VfhOtQgCnoqJkZQ9T/DmhLM=
Message-ID: <21d7e997050420161234141e23@mail.gmail.com>
Date: Thu, 21 Apr 2005 09:12:40 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: nVidia stuff again
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca>
	 <425D3924.1070809@nortel.com> <425E77BB.5010902@aitel.hist.no>
	 <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But *that's* the point people keep ignoring: the specs for programming
> the hardware, in some cases, reveals details about the hardware's
> implementation that nVidia does *not* want to release (in addition to
> suggesting their software tricks).  Why is it that people *assume* that
> just the programming docs tells a person nothing about the hardware?  We
> already know that knowing the registers of a card and what those
> registers do tells you implicit information about the card's design and
> also reveals implicit information about the design of software that
> works with the card.  How complex the card's registers and programming
> interface is determines how much you can infer, and the more RISC like
> or simple the card is and the more that is handled in the driver, the
> more obviously the design can be inferred just from the programming
> specs.

 I think the programming specs for a 3D graphics card can tell you
very little about it, the R200 specs are very good but I doubt anyone
would have a clue how to design the internals of the card just from
looking at them, and now that GPUs are getting more like CPUs in terms
of shaders and programming languages the specs are getting less and
less useful to tell what is actually going on....

The main reasons they don't like open source is from where I'm
standing, their IP lawyers and probably not being able to do sneaky
hacks in the driver because people can see them..

Dave.



> 
> The aic7xxx chips are a perfect example of this exact same thing.  If
> you know how to program the registers on that card, then you know almost
> everything about the hardware.  It's that simple (and that's a big part
> of what makes it very fast, lots of room for driver optimizations and
> enhanced feature support).
> 
> --
> Doug Ledford <dledford@redhat.com>
> http://people.redhat.com/dledford
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
