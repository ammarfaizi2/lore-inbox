Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSAYQSC>; Fri, 25 Jan 2002 11:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290714AbSAYQRw>; Fri, 25 Jan 2002 11:17:52 -0500
Received: from pcp809261pcs.nrockv01.md.comcast.net ([68.49.81.201]:6274 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290713AbSAYQRn>; Fri, 25 Jan 2002 11:17:43 -0500
Date: Fri, 25 Jan 2002 11:11:56 -0500
From: Olivier Galibert <galibert@pobox.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Xavier Bestel <xavier.bestel@free.fr>, timothy.covell@ashavan.org,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020125111156.A2871@zalem.nrockv01.md.comcast.net>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alexander Viro <viro@math.psu.edu>,
	Xavier Bestel <xavier.bestel@free.fr>, timothy.covell@ashavan.org,
	Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1011914865.2636.16.camel@bip> <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jan 25, 2002 at 01:13:21AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 01:13:21AM -0500, Alexander Viro wrote:
> BTW, he's got a funny compiler - I would expect at least a warning about
> use of uninitialized variable.

That would require -O.  Control path analysis is not done when not
optimizing.

  OG.
