Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268190AbTBNFvn>; Fri, 14 Feb 2003 00:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268210AbTBNFvn>; Fri, 14 Feb 2003 00:51:43 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:43855
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268190AbTBNFvl>; Fri, 14 Feb 2003 00:51:41 -0500
Date: Fri, 14 Feb 2003 01:00:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Sahara Workshop <workshop@cpt.saharapc.co.za>
cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with 2.5.*'s SCSI headers and cdrtools
In-Reply-To: <1045201685.5971.78.camel@workshop.saharact.lan>
Message-ID: <Pine.LNX.4.50.0302140056410.3518-100000@montezuma.mastecende.com>
References: <1045201685.5971.78.camel@workshop.saharact.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Sahara Workshop wrote:

> 
> Kernel 2.5.5x (have not tried earlier) and 2.5.60 's scsi/scsi.h do
> not have like in 2.4 the 'include <features.h>', or as it may seem
> to need an 'include <types.h>', and thus cdrtools for one do not
> compile.
> 
> The take I get on this from Jorg is that he feels its a problem
> kernel side.  Comments ?
> 
> Attached is a patch that get cdrtools-2.01a2 to compile.

Good heavens that's ugly, shouldn't you be using userland header files and 
not the ones from 'Kernel du jour'? Is your /usr/include/linux pointing to 
your current kernel? If that's the case.. don't do that.

What were Joerg's justifications again?

	Zwane

Aside: Are Sahara shipping computers with bleeding edge Linux 
configurations? ;)

-- 
function.linuxpower.ca
