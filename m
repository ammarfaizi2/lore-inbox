Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSFDTG0>; Tue, 4 Jun 2002 15:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSFDTGZ>; Tue, 4 Jun 2002 15:06:25 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:50934 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316574AbSFDTGX>;
	Tue, 4 Jun 2002 15:06:23 -0400
Date: Tue, 4 Jun 2002 15:06:17 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: device model documentation 1/3
Message-ID: <20020604190617.GA32671@www.kroptech.com>
In-Reply-To: <Pine.LNX.4.33.0206041040090.654-100000@geena.pdx.osdl.net> <Pine.LNX.4.33.0206041115540.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:26:41AM -0700, Patrick Mochel wrote:
> Actually, I take that back. attach is the wrong nomenclature as well for 
> the action. 'match' would be more correct.
> 
> The entry point is the opportunity for the bus to compare a device ID with
> a list of IDs that a particular driver supports. It's a 'compare' or
> 'match' operation. At this point, the driver is not attaching to the
> device; it's only checking that's its ok to attach.

Seems like what "probe" usually means...

--Adam

