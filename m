Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281923AbRKZQov>; Mon, 26 Nov 2001 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281922AbRKZQok>; Mon, 26 Nov 2001 11:44:40 -0500
Received: from ns.suse.de ([213.95.15.193]:47629 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281917AbRKZQoX>;
	Mon, 26 Nov 2001 11:44:23 -0500
Date: Mon, 26 Nov 2001 17:44:22 +0100
From: Andi Kleen <ak@suse.de>
To: berthiaume_wayne@emc.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast
Message-ID: <20011126174422.A16479@wotan.suse.de>
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB10@corpusmx1.us.dg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB10@corpusmx1.us.dg.com>; from berthiaume_wayne@emc.com on Mon, Nov 26, 2001 at 11:33:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 11:33:03AM -0500, berthiaume_wayne@emc.com wrote:
> 	Wouldn't the IP address for the two NIC's have to be different for
> that to work? I'm binding the same VIP to the two eth's.

ifindexes have nothing to do with IP addresses. If you tell the kernel
which interface(s) you want it'll follow your wishes.

There is not really an IP address per NIC; IP addresses are global per host
and the association with an IP interface just defines some defaults which
can be always overwritten by the user if he wants to.

-Andi
