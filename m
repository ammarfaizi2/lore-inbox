Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRDQBkz>; Mon, 16 Apr 2001 21:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDQBkq>; Mon, 16 Apr 2001 21:40:46 -0400
Received: from coruscant.franken.de ([193.174.159.226]:60935 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S132508AbRDQBkf>; Mon, 16 Apr 2001 21:40:35 -0400
Date: Mon, 16 Apr 2001 22:39:17 -0300
From: Harald Welte <laforge@gnumonks.org>
To: David Findlay <david_j_findlay@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010416223917.N16697@corellia.laforge.distro.conectiva>
In-Reply-To: <01041707532801.00352@workshop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <01041707532801.00352@workshop>; from david_j_findlay@yahoo.com.au on Tue, Apr 17, 2001 at 07:53:28AM +1000
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Sweetmorn, the 33rd day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 07:53:28AM +1000, David Findlay wrote:

> In the 2.5 series of kernels, working towards 2.6, could you please make the 
> IP Accounting so that I can set a single rule that will make it watch all IP 
> traffic going from the local network, through the masquerading service to the 
> internet, and log local IP Addresses using it? This would allow me to set 1 
> rule, but have the information I want on a per IP address system.

:) Well... there was a discussion about this on the netfilter-devel
list some weeks ago. 

This is definitely not a 2.5 / 2.6 issue, as it could be easily implemented
by using the already existing flexibility of netfilter/iptables.

It's just a matter of somebody who needs it getting around actually 
implementing it. Could be either implemented as a 'raw' netfilter 
hook-attaching module or (more convenient) as a new iptables target, 
which allocates some internal tables for storing the accounting data.

Doesn't make sense to have a discussion about it on linux-kernel, and
it certainly doesn't belong into a 2.5 featurelist.

Please refer to the netfilter-devel mailinglist (subscription information
available at http://netfilter.samba.org/)

> David

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
