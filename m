Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLABV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 20:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTLABV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 20:21:59 -0500
Received: from holomorphy.com ([199.26.172.102]:5064 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262758AbTLABV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 20:21:58 -0500
Date: Sun, 30 Nov 2003 17:21:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031201012126.GN8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James W McMechan <mcmechanjw@juno.com>,
	linux-kernel@vger.kernel.org
References: <20031130.131750.-1591395.3.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130.131750.-1591395.3.mcmechanjw@juno.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 01:17:46PM -0800, James W McMechan wrote:
> Unable to handle kernel paging request at virtual address 00200200
> c018a152
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c018a152>]    Not tainted

This is significantly different in nature from the 2.4 oops, since
2.4 hit NULL and this pointer is total garbage.

Either it's a double bitflip or even worse is afoot.


-- wli
