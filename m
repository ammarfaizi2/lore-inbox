Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUEGQRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUEGQRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUEGQRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:17:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45706 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263679AbUEGQRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:17:06 -0400
Date: Fri, 07 May 2004 09:16:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
Message-ID: <540080000.1083946609@[10.10.2.4]>
In-Reply-To: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI is used to do some hardware manipulation.
> There is no general purpose interface to get hardware information
> and manipulate hardware today, but hardware proprietary interfaces.
> ACPI is one of them, and I decided to use it because:
> 
>   - Its spec is open.
>   - I can use it without any hardware special knowledge:)

You can't base platform-independant Linux code on ACPI, when not all
NUMA boxes will support it. The fact that your particular box may
support it doesn't make it a generally applicable idea ;-)

You need a better abstraction (and preferably one without the massive 
complexity whilst you're at it).

M.

