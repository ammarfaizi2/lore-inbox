Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTJQBcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTJQBcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:32:46 -0400
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:62089 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263270AbTJQBcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:32:45 -0400
From: jlnance@unity.ncsu.edu
Date: Thu, 16 Oct 2003 21:32:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017013245.GA6053@ncsu.edu>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016230448.GA29279@pegasys.ws>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 04:04:48PM -0700, jw schultz wrote:
> 
> The idea of this sort of block level hashing to allow
> sharing of identical blocks seems attractive but i wouldn't
> trust any design that did not accept as given that there
> would be false positives.

But at the same time we rely on TCP/IP which uses a hash (checksum)
to detect back packets.  It seems to work well in practice even
though the hash is weak and the network corrupts a lot of packets.

Lots of machines dont have ECC ram and seem to work reasonably well.

It seems like these two are a lot more likely to bit you than hash
collisions in MD5.  But Ill have to go read the paper to see what
Im missing.

Thanks,

Jim
