Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSKCD0J>; Sat, 2 Nov 2002 22:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSKCD0J>; Sat, 2 Nov 2002 22:26:09 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:24580 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261576AbSKCD0I>; Sat, 2 Nov 2002 22:26:08 -0500
Date: Sun, 3 Nov 2002 03:32:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Kernel GUI config
Message-ID: <20021103033238.A11874@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021102231435.GA2384@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021102231435.GA2384@werewolf.able.es>; from jamagallon@able.es on Sun, Nov 03, 2002 at 12:14:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:14:35AM +0100, J.A. Magallón wrote:
> Hi all...
> 
> I have readl all the comments about qconfig, gconfig, etc..., and I wanto to
> comment about an idea that perhaps can make everybody happy...
> 
> I don't like qt. As many others. Others do not like GTK. QT requires a C++
> compiler to configure the kernel. Everybody agrees on putting the gui config
> tool outside the tree. So...
> 
> - Make a new target called 'guiconfig'. This is neutral, and just should call
>   an utility called for example kconfig-gui.

Why do you need a target?  Just install your preferred tool into /usr/bin
and invoke it directly from there.

