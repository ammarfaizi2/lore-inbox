Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTLDSWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTLDSWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:22:17 -0500
Received: from holomorphy.com ([199.26.172.102]:14545 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263389AbTLDSWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:22:16 -0500
Date: Thu, 4 Dec 2003 10:22:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jason Walker <jason_walker@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to address 1GB RAM in 2.4.19 or later
Message-ID: <20031204182213.GY8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jason Walker <jason_walker@bellsouth.net>,
	linux-kernel@vger.kernel.org
References: <20031204181014.QPLW12995.imf20aec.mail.bellsouth.net@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204181014.QPLW12995.imf20aec.mail.bellsouth.net@debian>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 01:10:31PM -0500, Jason Walker wrote:
> I have run into an issue where I cannot address all of my 1GB of RAM. 2.4.18
> was the last kernel that can address all 1GB. All kernels since then appear to
> only be able to address 16mb of ram if I use the 4GB himem kernel option. Here
> is a snip of the dmesg on the working 2.4.18 and broken 2.4.23 kernels:

Your BIOS' e820 is bust.


-- wli
