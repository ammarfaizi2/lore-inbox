Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291908AbSBIJNZ>; Sat, 9 Feb 2002 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291910AbSBIJNP>; Sat, 9 Feb 2002 04:13:15 -0500
Received: from coruscant.franken.de ([193.174.159.226]:28339 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S291908AbSBIJNB>; Sat, 9 Feb 2002 04:13:01 -0500
Date: Sat, 9 Feb 2002 10:06:14 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Olaf Zaplinski <olaf.zaplinski@web.de>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.samba.org
Subject: Re: iptables: why different behaviour with two kernel versions?
Message-ID: <20020209100614.U26676@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Olaf Zaplinski <olaf.zaplinski@web.de>,
	linux-kernel@vger.kernel.org, netfilter@lists.samba.org
In-Reply-To: <3C645047.C2C248B8@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C645047.C2C248B8@web.de>; from olaf.zaplinski@web.de on Fri, Feb 08, 2002 at 11:25:11PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 11:25:11PM +0100, Olaf Zaplinski wrote:
> Hi all,

Hi Olaf.

Please direct iptables usage questions to the netfilter@lists.samba.org
mailinglist (as stated in the MAINTAINERS file).

> my self made firewall at $HOME (iptables based) works fine, but the
> accounting data it reports every day is not as expected.
[...]

>From what you have written, I can draw the assumption that you think
forwarded packets go through INPUT or OUTPUT?  Then you're thinking in
2.2.x ipchains terms.

In 2.4.x (== iptables) firewalling, forwarded packets go only through 
output.

> So I built the 2.4.13 kernel to test that and got dozens of rejects in the
> logs, e.g. UDP connects to the DNS forwarders... so I could not test the
> accounting stuff. I switched back to 2.4.17 and everything was fine again.
> 
> So what's wrong with iptables-1.2.4 userland tools and 2.4.[13|17]? Why is
> iptables-rules@2.4.13 not the same as iptables-rules@2.4.17?

Maybe something else in your setup was different?  There is no difference
between the filter table in 2.4.13 and 2.4.17.

> Olaf

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
