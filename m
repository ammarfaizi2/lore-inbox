Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbULQRDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbULQRDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbULQRDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:03:41 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:17105 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262071AbULQRDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:03:37 -0500
Date: Fri, 17 Dec 2004 12:03:36 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Park Lee <parklee_sel@yahoo.com>, pmarques@grupopie.com, mingo@redhat.com,
       linux-os@chaos.analogic.com, linux-kernel@vger.kernel.org,
       ipsec-tools-devel@lists.sourceforge.net
Subject: Re: Issue on netconsole vs. Linux kernel oops
Message-ID: <20041217170336.GA12057@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Matt Mackall <mpm@selenic.com>, Park Lee <parklee_sel@yahoo.com>,
	pmarques@grupopie.com, mingo@redhat.com, linux-os@chaos.analogic.com,
	linux-kernel@vger.kernel.org, ipsec-tools-devel@lists.sourceforge.net
References: <20041217121220.9782.qmail@web51510.mail.yahoo.com> <20041217164419.GO2767@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217164419.GO2767@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 08:44:19AM -0800, Matt Mackall wrote:
> Netconsole builds very simple IPv4 packets by hand without the use of
> the rest of the IP stack. This is how it continues to work when the
> system is crashing. So it will never be able to build IPSEC packets.
> Nor is it likely to do IPv6 any time soon.

A useful (and perhaps relatively painless?) addition to netconsole would
be VLAN support.  This is somewhere near the middle of my TODO list.

Regards,

	Bill Rugolsky
