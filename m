Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVFMW17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVFMW17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFMW0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:26:17 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:63634 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261558AbVFMWZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:25:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=aICdFux6OiOCo7iif6aYmipyHFbtPkYKrBZ9piLEwyT3bYGh6fkhZ5dYnELFhG2hPfKzvyJv+tiS1AK85WPb/Gu+PIckcqR7m2/NZgMyP2lviWYnsGTUUfowBE3z9EySegsB0ITNFdjNiVSkTDyFXcy2G040G/sOd14B/eOISPY=
Date: Tue, 14 Jun 2005 00:25:28 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050613222527.GB8629@gmail.com>
References: <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613213307.GA8534@gmail.com> <1118699191.5079.49.camel@mulgrave> <20050613215923.GA8629@gmail.com> <1118700284.5079.52.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118700284.5079.52.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 05:04:44PM -0500, James Bottomley wrote:

> Well ... just to confirm for this one: although it's on a u160
> controller, you have its speed configured in bios to 40MHz (rather than
> 80Mhz)?  That's what the value of flags seems to say, and we look to be
> interpreting it correctly.

Yes, due to those problem, I have reduced all devices speed on both
controllers. Now I think I can put the HD to 160 and my CD-writers to
20 :-) (Maybe I could try to also put the DVD-Rom to 20).

Do you think it's safe to use this patched 2.6.12-rc6 (I could stay
under 2.6.12-rc2 till 2.6.12-rc7 or 2.6.12 comes out) ?

Thank you very much,
-- 
	Gr\'egoire Favre
