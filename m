Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262965AbTCWIUa>; Sun, 23 Mar 2003 03:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbTCWIUa>; Sun, 23 Mar 2003 03:20:30 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:17932 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262965AbTCWIU3>; Sun, 23 Mar 2003 03:20:29 -0500
Date: Sun, 23 Mar 2003 08:31:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: mauelshagen@sistina.com
Cc: linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: System Starvation under heavy io load with HIGHMEM4G
Message-ID: <20030323083133.B6732@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	mauelshagen@sistina.com, linux-kernel@vger.kernel.org,
	mge@sistina.com
References: <20030321190753.A16925@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030321190753.A16925@sistina.com>; from Heinz.Mauelshagen@t-online.de on Fri, Mar 21, 2003 at 07:07:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:07:53PM +0100, Heinz J . Mauelshagen wrote:
> Regards,
> Heinz    -- The LVM Guy --
> 
> [1.] 2.4.20 starvation under heavy write io
> 
> [2.] Full description of the problem/report:
> 
> Copying 12g onto a 67g ext2 fs causes the system to 'hang' with HIGHMEM4G
> configured (system has 1.5GB RAM) after trying to allocate a bounce buffer.

Unfortunately the mainline VM is basically unmoainted, I'd try to use the
rmap or -aa patches instead (or even better some vendor tree)

