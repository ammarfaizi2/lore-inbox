Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSHZTYL>; Mon, 26 Aug 2002 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSHZTYL>; Mon, 26 Aug 2002 15:24:11 -0400
Received: from AMarseille-201-1-2-149.abo.wanadoo.fr ([193.253.217.149]:8048
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317673AbSHZTYK>; Mon, 26 Aug 2002 15:24:10 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Egger <degger@fhm.edu>, Alan Cox <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4-ac2
Date: Mon, 26 Aug 2002 22:37:20 +0200
Message-Id: <20020826203720.1562@192.168.4.1>
In-Reply-To: <1030388788.2797.13.camel@irongate.swansea.linux.org.uk>
References: <1030388788.2797.13.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If it was x86 I'd say "keep it for 2.4, delete it in 2.5, in the 2.4 one
>add a printk advising people to switch driver". I don't know how the ppc
>world is accustomed to handling this though

Well, we aren't not really accustomed to obsoleting a driver yet ;)

My original intend was just that (keep it in 2.4 and delete it in 2.5)
but now, working sungem has been around 2.4 for quite some time and new
machines aren't properly suported by it etc...

The printk big bold warning on driver load may be the best option for 2.4

Ben.


