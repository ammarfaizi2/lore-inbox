Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTFYW5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFYW5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:57:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43393
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265163AbTFYW47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:56:59 -0400
Subject: Re: DVB Include files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Marcus Metzler <mocm@metzlerbros.de>,
       Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
       Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625202312.GG1770@wohnheim.fh-wedel.de>
References: <20030625181606.A29104@infradead.org>
	 <16121.55873.675690.542574@sheridan.metzler>
	 <20030625182409.A29252@infradead.org>
	 <16121.56382.444838.485646@sheridan.metzler>
	 <20030625185036.C29537@infradead.org>
	 <16121.58735.59911.813354@sheridan.metzler>
	 <20030625191532.A1083@infradead.org>
	 <16121.60747.537424.961385@sheridan.metzler>
	 <20030625194250.GF1770@wohnheim.fh-wedel.de>
	 <16122.379.321217.737557@sheridan.metzler>
	 <20030625202312.GG1770@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1056582481.1998.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jun 2003 00:08:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-25 at 21:23, Jörn Engel wrote:
> So you don't recompile, but you still changed the magic ioctl numbers
> from 17 to 47 and from 18 to 48.  Old binaries don't work any more,
> even though the same semantics are still present.  That is an
> incompatible change in my book.
> 
> Worse if there is a new semantic for 17 or 18, in that case the old
> binaries may break randomly, depending on kernel version.

Sure but you keep old ones around once its stable. This is a completely
pointless conversation to have before 2.6.0-test kernels. There isnt a
stable in kernel dvb api yet because its not been shipped in a stable
kernel.

(Although I'd note the api has been as stable if not more stable than
some in kernel stuff 8))

