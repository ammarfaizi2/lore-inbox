Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284073AbRL1Q7i>; Fri, 28 Dec 2001 11:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283626AbRL1Q7T>; Fri, 28 Dec 2001 11:59:19 -0500
Received: from cabal.xs4all.nl ([213.84.101.140]:43454 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S283438AbRL1Q7K>;
	Fri, 28 Dec 2001 11:59:10 -0500
Date: Fri, 28 Dec 2001 17:59:08 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
Subject: Re: link error in SCC driver
Message-ID: <20011228165908.GL7481@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org
In-Reply-To: <20011228164111.GK7481@wiggy.net> <Pine.LNX.4.33.0112281756140.22038-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112281756140.22038-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Dave Jones wrote:
> output of Keiths reference_discarded.pl would be useful.
> http://kernelnewbies.org/scripts/reference_discarded.pl

Hmm, bugger. It's nog even the SCC driver as I guessed:

[maltimi;~/linux]-36> perl ../reference_discarded.pl 
Finding objects, 443 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 37 conglomerate(s)
Scanning objects
Error: ./net/ipv4/netfilter/ip_nat_snmp_basic.o .text.lock refers to 0000004c R_386_PC32        .text.exit

Wichert.

-- 
  _________________________________________________________________
 /wichert@wiggy.net         This space intentionally left occupied \
| wichert@deephackmode.org            http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
