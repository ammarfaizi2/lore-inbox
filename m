Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293234AbSBWWfX>; Sat, 23 Feb 2002 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSBWWfN>; Sat, 23 Feb 2002 17:35:13 -0500
Received: from coruscant.franken.de ([193.174.159.226]:61098 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S293234AbSBWWe5>; Sat, 23 Feb 2002 17:34:57 -0500
Date: Sat, 23 Feb 2002 23:23:08 +0100
From: Harald Welte <laforge@gnumonks.org>
To: ertzog <ertzog@bk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet bridging and firewalling
Message-ID: <20020223232308.X23307@sunbeam.de.gnumonks.org>
In-Reply-To: <Pine.LNX.4.21.0202192008310.1623-100000@dial-up-2.energonet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0202192008310.1623-100000@dial-up-2.energonet.ru>; from ertzog@bk.ru on Tue, Feb 19, 2002 at 08:09:25PM +0000
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Setting Orange, the 50th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 08:09:25PM +0000, ertzog wrote:
> Will the patch
> http://bridge.sourceforge.net/devel/bridge-nf/bridge-nf-0.0.6-against-2.4.17.diff
> 
> be included in mainstream?
> It enables firewalling with bridging.

No.  The issues of this have been discussed on the netfilter developer meeting
(where Lennert was also present) - there's a summary available at 
http://www.netfilter.org/documentation/events/netfilter-ws-2001-summary.txt

The basic issue is that it adds multiple new struct sk_buff members, which
is generally not considered as a good idea by the networking gods ;)

> Best regards.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
