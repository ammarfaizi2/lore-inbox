Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbUBYNTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUBYNTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:19:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:57616 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261319AbUBYNTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:19:34 -0500
Date: Wed, 25 Feb 2004 13:19:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040225131932.B3966@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20040224195745.GA777@kroah.com> <Pine.LNX.4.44.0402241728460.21522-100000@chimarrao.boston.redhat.com> <20040225002819.GP1751@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040225002819.GP1751@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Feb 25, 2004 at 02:28:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 02:28:19AM +0200, Matti Aarnio wrote:
> Another thing (for which I would have use at hand right away, actually)
> is to have fully functional Fibre Channel subsystem in Linux along
> with drivers to modern cards e.g. JNI's.  (2 Gbit/s FC)
> 
> Plugging tens of terabytes of disks on a box is somewhat challenging
> without resorting to that technology...

There's better troll than you, Matti :)

In a stock 2.6 kernel you get support for the following 2GB FC adapters:

  Qlogic 2xxx/6xxx (PCI-X/ PCI-Express)
  LSI Fusion
  IBM zfcp (okay, you need a mainframe for that, but.. :))

if you like a crappy out of tree vendor driver you can also get Emulex
support.  You belowed vendor JNI unfortunately only has binary only drivers
for intel plattforms and 2.2/2.4 kernels.

