Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbSKCQmj>; Sun, 3 Nov 2002 11:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSKCQmj>; Sun, 3 Nov 2002 11:42:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35213 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262194AbSKCQmi> convert rfc822-to-8bit; Sun, 3 Nov 2002 11:42:38 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ragnar =?ISO-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103173016.E30076@vestdata.no>
References: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk>
	<E188MXo-00074b-00@sites.inka.de>  <20021103173016.E30076@vestdata.no>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 17:10:24 +0000
Message-Id: <1036343424.30679.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 16:30, Ragnar Kjørstad wrote:
> On Sun, Nov 03, 2002 at 04:20:08PM +0100, Bernd Eckenfels wrote:
> > In article <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> you wrote:
> > > Namespaces is a way to inherit revocation of rights on a large scale (or
> > > a small one true). #! is a way to handle program specific revocation of
> > > rights which _is_ filesystem persistent.
> > 
> > #! would be a nice option to increase capabilities on invocation. But the
> > final target must be linked to the invocation by an entity/revision binding.
> > Since we do not have modification versions i could think about checksums:
> 
> Unfortenately it will be much harder to find all executables with
> increased capabilities on your system. 

You need a way to mark applications which may be run with increased
capabilities and which ones are permitted yes, and by object not by name

