Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283783AbRL1RJS>; Fri, 28 Dec 2001 12:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283916AbRL1RJJ>; Fri, 28 Dec 2001 12:09:09 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:49541 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S284090AbRL1RIu>; Fri, 28 Dec 2001 12:08:50 -0500
Date: Fri, 28 Dec 2001 12:08:47 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Wichert Akkerman <wichert@wiggy.net>
cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
        linux-hams@vger.kernel.org
Subject: Re: link error in SCC driver
In-Reply-To: <20011228165908.GL7481@wiggy.net>
Message-ID: <Pine.A41.4.21L1.0112281206560.20874-100000@login4.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, was just going to ask if you were compiling netfilter options
statically or modularly. I've gotten the same error (as has Adrian
Bunk and perhaps countless others) by compiling them in statically,
so for now I just compile them as modules.

---
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

On Fri, 28 Dec 2001, Wichert Akkerman wrote:

> Hmm, bugger. It's nog even the SCC driver as I guessed:
> 
> [maltimi;~/linux]-36> perl ../reference_discarded.pl 
> Finding objects, 443 objects, ignoring 0 module(s)
> Finding conglomerates, ignoring 37 conglomerate(s)
> Scanning objects
> Error: ./net/ipv4/netfilter/ip_nat_snmp_basic.o .text.lock refers to 0000004c R_386_PC32        .text.exit
> 
> Wichert.
> 
> 

