Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbSLKUyO>; Wed, 11 Dec 2002 15:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbSLKUyO>; Wed, 11 Dec 2002 15:54:14 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:61635
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267317AbSLKUyO>; Wed, 11 Dec 2002 15:54:14 -0500
Subject: Re: atyfb in 2.5.51
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: jsimmons@infradead.org, benh@kernel.crashing.org, paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20021211.124347.127990341.davem@redhat.com>
References: <1039596149.24691.2.camel@rth.ninka.net>
	<Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net> 
	<20021211.124347.127990341.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 21:35:10 +0000
Message-Id: <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 20:43, David S. Miller wrote:
> fbdev is nice, in the specific cases where the device fits the fbdev
> model, because once you have the kernel bits you have X support :)

fbdev also can't be used in some situations on x86. Deeply fascinating
things happen on some x86 processors if you execute a loop of code with
an instruction that crosses two different memory types.


