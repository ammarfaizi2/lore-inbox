Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUILXAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUILXAc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUILXAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:00:32 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39582
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263769AbUILXAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:00:22 -0400
Date: Sun, 12 Sep 2004 15:58:50 -0700
From: "David S. Miller" <davem@davemloft.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: ag@roxor.be, linux-kernel@vger.kernel.org
Subject: Re: iMac G3 IPv6 issue
Message-Id: <20040912155850.0e8fd0b5.davem@davemloft.net>
In-Reply-To: <1095011851.4995.54.camel@localhost.localdomain>
References: <20040912133936.GA11099@caladan.roxor.be>
	<1095011851.4995.54.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 18:57:31 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Sun, 2004-09-12 at 15:39 +0200, Aurélien GÉRÔME wrote:
> > I put IPv6 support, but the console is flooded by a lot of:
> > hw tcp v6 csum failed
> > However, IPv6 works, and IPv4 packets do not have this kind of issue.
> > The network card is a Sun Gem. It is kind of weird to see bad packets.
> 
> I use the sungem in a similar machine with IPv6, and haven't seen any
> problems. Can you tcpdump from a different machine on the network and
> confirm whether these reported bad checksums really are happening or if
> it's the fault of the hardware/driver?

One thing that's interesting is that the sungem and sunhme
drivers are the only two in the whole tree that support
IPV6 checksum offload.  Like David, I have never seen this
problem on Sparc systems using the GEM chip and this
driver.
