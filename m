Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbSJVVHL>; Tue, 22 Oct 2002 17:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSJVVHL>; Tue, 22 Oct 2002 17:07:11 -0400
Received: from coruscant.franken.de ([193.174.159.226]:58031 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262055AbSJVVHK>; Tue, 22 Oct 2002 17:07:10 -0400
Date: Tue, 22 Oct 2002 17:04:14 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: trivial netfilter compile problem in 2.5.4[34]-mm2
Message-ID: <20021022150414.GN3039@naboo.club.berlin.ccc.de>
References: <3DB46781.D4245373@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DB46781.D4245373@folkwang-hochschule.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.19-pre4-ben0
X-Date: Today is Sweetmorn, the 72nd day of Bureaucracy in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 10:45:53PM +0200, Joern Nettingsmeier wrote:
> hi *!
> 
> 
> in order to compile 2.5.4[34], i had to add #include
> <linux/netfilter_ipv4> to net/ipv4/raw.c, since it choked on
> NF_IP_LOCAL_OUT being undefined in line 297.
> 
> since i've had this problem for two kernel releases now, i thought i'd
> bring this to your attention.

Thanks a lot, I will investigate this once I am close to an internet
connection and can download the respective kernel version(s).

> regards,
> jörn

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
