Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbTCaS4D>; Mon, 31 Mar 2003 13:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbTCaS4C>; Mon, 31 Mar 2003 13:56:02 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:3303 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S261789AbTCaS4C>;
	Mon, 31 Mar 2003 13:56:02 -0500
Date: Mon, 31 Mar 2003 20:56:48 +0200
From: Simone Piunno <pioppo@ferrara.linux.it>
To: Peter Bieringer <pb@bieringer.de>
Cc: usagi-users@linux-ipv6.org, netdev@oss.sgi.com, ds6-devel@deepspace6.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ds6-devel] Re: (usagi-users 02296) IPv6 duplicate address bugfix
Message-ID: <20030331185648.GA3928@ferrara.linux.it>
References: <20030330122705.GA18283@ferrara.linux.it> <9360000.1049135038@worker.muc.bieringer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9360000.1049135038@worker.muc.bieringer.de>
User-Agent: Mutt/1.4i
Organization: Ferrara LUG
X-Operating-System: Linux 2.4.20-skas3
X-Message: GnuPG/PGP5 are welcome
X-Key-ID: 860314FC/C09E842C
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 08:23:58PM +0200, Peter Bieringer wrote:

> Address was already added by autoconfiguration on receiving advertisement
> (limited lifetime). Now the same address would be added manually (unlimited
> lifetime).
> 
> What (should) happen?
> 
> Mho: manual add is allowed, both addresses need to be listed.

I'd prefer this variant:

manual add is allowed and overwrites the autoconfigured address.

-- 
 Simone Piunno -- http://members.ferrara.linux.it/pioppo 
.-------  Adde parvum parvo magnus acervus erit  -------.
 Ferrara Linux Users Group - http://www.ferrara.linux.it 
 Deep Space 6, IPv6 on Linux - http://www.deepspace6.net 
 GNU Mailman, Mailing List Manager - http://www.list.org 
`-------------------------------------------------------'
