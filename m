Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317710AbSFMP2w>; Thu, 13 Jun 2002 11:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317728AbSFMP2v>; Thu, 13 Jun 2002 11:28:51 -0400
Received: from oyster.morinfr.org ([62.4.22.234]:8576 "EHLO oyster.morinfr.org")
	by vger.kernel.org with ESMTP id <S317710AbSFMP2v>;
	Thu, 13 Jun 2002 11:28:51 -0400
Date: Thu, 13 Jun 2002 17:28:51 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: TCP checksum?
Message-ID: <20020613152851.GA3442@morinfr.org>
Mail-Followup-To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840636@es06snlnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 13 jun à  9:10, Shipman, Jeffrey E écrivait :
>
> I'm looking for a function similar to skb_checksum(), but
> for the tcphdr->check field. I'm playing around with a module
> I've written for netfilter and I would like to modify options of
> the IP and TCP headers. For example, right now I'm trying
> to set the destination IP to the source IP, but the TCP checksum
> is coming out incorrectly. How can I calculate this checksum?

There is a netfilter function for that. Look at
ip_nat_core.c:ip_nat_cheat_check.

-- 
Guillaume Morin <guillaume@morinfr.org>

          5 years from now everyone will be running free GNU on their
           200 MIPS, 64M SPARCstation-5 (Andy Tanenbaum, 30 Jan 1992)
