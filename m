Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291475AbSBHIxV>; Fri, 8 Feb 2002 03:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291477AbSBHIxL>; Fri, 8 Feb 2002 03:53:11 -0500
Received: from coruscant.franken.de ([193.174.159.226]:39045 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S291475AbSBHIw5>; Fri, 8 Feb 2002 03:52:57 -0500
Date: Fri, 8 Feb 2002 09:46:49 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: 2.4.18-pre9: iptables screwed?
Message-ID: <20020208094649.J26676@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.samba.org
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Feb 07, 2002 at 08:24:28PM -0800
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 08:24:28PM -0800, H. Peter Anvin wrote:
> I get the following error with iptables on 2.4.18-pre9:
> 
> sudo iptables-restore < /etc/sysconfig/iptables
> iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> Abort (core dumped)
> 
> However, if I apply the rules manually (using iptables), I have no
> problem; only if I'm using iptables-save or iptables-restore do I get
> a dump...

Could you please tell me, what iptables version are you using? 
(btw: please follow-up to netfilter-devel@lists.samba.org)

> 	-hpa

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
