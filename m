Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUILSDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUILSDC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUILSDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:03:01 -0400
Received: from canuck.infradead.org ([205.233.218.70]:53003 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S268756AbUILSCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:02:54 -0400
Subject: Re: iMac G3 IPv6 issue
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?Aur=E9lien_G=C9R=D4ME?= <ag@roxor.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040912133936.GA11099@caladan.roxor.be>
References: <20040912133936.GA11099@caladan.roxor.be>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Sep 2004 18:57:31 +0100
Message-Id: <1095011851.4995.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 15:39 +0200, Aurélien GÉRÔME wrote:
> I put IPv6 support, but the console is flooded by a lot of:
> hw tcp v6 csum failed
> However, IPv6 works, and IPv4 packets do not have this kind of issue.
> The network card is a Sun Gem. It is kind of weird to see bad packets.

I use the sungem in a similar machine with IPv6, and haven't seen any
problems. Can you tcpdump from a different machine on the network and
confirm whether these reported bad checksums really are happening or if
it's the fault of the hardware/driver?

-- 
dwmw2

