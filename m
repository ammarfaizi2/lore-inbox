Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268685AbTCCWny>; Mon, 3 Mar 2003 17:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268833AbTCCWny>; Mon, 3 Mar 2003 17:43:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44444
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268685AbTCCWnx>; Mon, 3 Mar 2003 17:43:53 -0500
Subject: Re: Horrible L2 cache effects from kernel compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303031108390.12011-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303031108390.12011-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 23:58:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 19:13, Linus Torvalds wrote:
> dentry itself. Yes, you could make it smaller (you could remove the inline
> string from it, for example, and you could avoid allocating it at

How about at least making the inline string align to the slab alignment so we
dont waste space ?

