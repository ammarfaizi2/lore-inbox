Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUBJItg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 03:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUBJItH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 03:49:07 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:38867 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265780AbUBJItC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 03:49:02 -0500
Date: Tue, 10 Feb 2004 08:46:05 +0000
From: Dave Jones <davej@redhat.com>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Matt Mackall <mpm@selenic.com>, Tom Rini <trini@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, akpm@osdl.org, george@mvista.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040210084605.GA27889@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Amit S. Kale" <amitkale@emsyssoft.com>,
	Matt Mackall <mpm@selenic.com>,
	Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@suse.cz>,
	akpm@osdl.org, george@mvista.com, Andi Kleen <ak@suse.de>,
	jim.houston@comcast.net,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040127184029.GI32525@stop.crashing.org> <20040209155013.GF5219@smtp.west.cox.net> <20040209173828.GG2315@waste.org> <200402101327.40378.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402101327.40378.amitkale@emsyssoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 01:27:40PM +0530, Amit S. Kale wrote:
 > http://www.codemonkey.org.uk/projects/bitkeeper/kgdb/kgdb-2004-02-10.diff
 > has grown over 10MB. Something wrong in generating a diff?

More likely mainline got ahead of the kgdb patch.

http://www.codemonkey.org.uk/projects/bitkeeper/kgdb/ is a diff
generated using bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+

It's a tenth of the size. Look better ?

		Dave

