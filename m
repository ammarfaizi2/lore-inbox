Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTFFHuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264703AbTFFHuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:50:39 -0400
Received: from rth.ninka.net ([216.101.162.244]:38785 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264694AbTFFHui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:50:38 -0400
Subject: Re: GE traffic statistics (/proc/net/dev)
From: "David S. Miller" <davem@redhat.com>
To: uaca@alumni.uv.es
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030605142005.GA9292@pusa.informat.uv.es>
References: <20030605142005.GA9292@pusa.informat.uv.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054886644.23214.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 01:04:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 07:20, uaca@alumni.uv.es wrote:
> I found very extrange that, for this device, stats on /proc/net/dev updates 
> each second (more or less), that is, not in sub-second intervals. Again note
> this only happens for this device and not for other NIC card (Fast-Ethernet 
> card, e100).

The chip only periodically sends updated statistics to main
memory via DMA, the interval can be changed using the
'ethtool' utility.

-- 
David S. Miller <davem@redhat.com>
