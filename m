Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJANaJ>; Tue, 1 Oct 2002 09:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJANaJ>; Tue, 1 Oct 2002 09:30:09 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:13243 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261614AbSJANaI>; Tue, 1 Oct 2002 09:30:08 -0400
Date: Tue, 1 Oct 2002 15:35:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Jones <davej@codemonkey.org.uk>
cc: "David L. DeGeorge" <dld@degeorge.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
In-Reply-To: <20021001111826.GA18583@suse.de>
Message-ID: <Pine.GSO.3.96.1021001153347.13606C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Dave Jones wrote:

> Some of the tualatins have an errata which makes L2 cache sizing
> impossible. They actually report they have 0K L2 cache. By checking
> the CPU model, we can guess we have at least 256K (which is where Linux
> got that number from in your case). But this however means the 512K
> models will report as 256K too.
> To work around it, boot with cachesize=512 and all will be good.

 Strange -- why not to default to 256K and override it with the value
obtained from a cache descriptor if != 0, then?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


