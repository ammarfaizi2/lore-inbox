Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268372AbTBWK3d>; Sun, 23 Feb 2003 05:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268377AbTBWK3d>; Sun, 23 Feb 2003 05:29:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6366 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268365AbTBWK3b>;
	Sun, 23 Feb 2003 05:29:31 -0500
Date: Sun, 23 Feb 2003 02:23:21 -0800 (PST)
Message-Id: <20030223.022321.113936550.davem@redhat.com>
To: ak@suse.de
Cc: hch@infradead.org, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030223103039.GA19725@wotan.suse.de>
References: <20030223100234.B15347@infradead.org>
	<20030223.015511.63413067.davem@redhat.com>
	<20030223103039.GA19725@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Sun, 23 Feb 2003 11:30:39 +0100

   On Sun, Feb 23, 2003 at 01:55:11AM -0800, David S. Miller wrote:
   > My bad.  Thanks for spotting this.
   
   Won't work if the IPv4 code is ever made modular.

Right, which is why I can't use per_cpu on the ipv6 side.
