Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSLIJA5>; Mon, 9 Dec 2002 04:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSLIJAb>; Mon, 9 Dec 2002 04:00:31 -0500
Received: from holomorphy.com ([66.224.33.161]:50583 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264978AbSLII6q>;
	Mon, 9 Dec 2002 03:58:46 -0500
Date: Mon, 9 Dec 2002 01:06:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.50-mjb1 (scalability / NUMA patchset)
Message-ID: <20021209090605.GC9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <19270000.1038270642@flay> <134580000.1039414279@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134580000.1039414279@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 10:11:19PM -0800, Martin J. Bligh wrote:
> Speed up page init on boot (Bill Irwin)

This needs a one-liner to go from fls() to ffs() since alignment is
required and things falling on alignment boundaries have fls(n) == ffs(n)

Very straightforward indeed; one-liners off from the 3rd or 4th boot
must be very obvious observations.


Bill
