Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbTCIEX2>; Sat, 8 Mar 2003 23:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262433AbTCIEX2>; Sat, 8 Mar 2003 23:23:28 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57240 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262428AbTCIEW7>;
	Sat, 8 Mar 2003 23:22:59 -0500
Message-Id: <200303090433.h294Wuu6005571@eeyore.valparaiso.cl>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev 
In-Reply-To: Your message of "Fri, 07 Mar 2003 14:55:18 -0800."
             <20030307225517.GF2835@ca-server1.us.oracle.com> 
Date: Sun, 09 Mar 2003 00:32:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> said:
> On Fri, Mar 07, 2003 at 02:12:17PM -0800, Greg KH wrote:
> > On Fri, Mar 07, 2003 at 12:30:29PM -0800, Andrew Morton wrote:
> > > 32-bit dev_t is an important (and very late!) thing to get into the 2.5
> > > stream.  Can we put this ahead of cleanup stuff?
> > 
> > Can we get people to agree that this will even go into 2.5, due to the
> > lateness of it?  I didn't think it was going to happen.
> 
> 	This is essential.  There are installations using >1000 disks
> today (on other OSes, generally).  It can't wait another 2.5 years.

This kind of changes in the middle of feature freeze are exactly what gets
you to 2.5 years.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
