Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbULWNvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbULWNvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 08:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbULWNvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 08:51:08 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:34998 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261241AbULWNvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 08:51:01 -0500
Date: Thu, 23 Dec 2004 14:50:59 +0100
From: bert hubert <ahu@ds9a.nl>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pc stalling when processing large files [2.6.9]
Message-ID: <20041223135059.GA12540@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Folkert van Heusden <folkert@vanheusden.com>,
	linux-kernel@vger.kernel.org
References: <20041223131135.GA11257@outpost.ds9a.nl> <Pine.LNX.4.33.0412231447070.28376-100000@muur.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0412231447070.28376-100000@muur.intranet.vanheusden.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 02:49:15PM +0100, Folkert van Heusden wrote:
> /usr/sbin/hdparm -c 3 -d 1 -X 69 -u 1 /dev/hda

And if you remove that line, does that help?

Also, output of 'vmstat 1' during stalls would be helpful.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
