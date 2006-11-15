Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162004AbWKOWbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162004AbWKOWbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031009AbWKOWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:31:44 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:28492 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1030776AbWKOWbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:31:43 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org>
	<20061114.201549.69019823.davem@davemloft.net>
	<455A9664.50404@garzik.org> <20061115110953.6cafdef8@freekitty>
	<455B6928.5030202@garzik.org> <20061115114928.6ff0936e@freekitty>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 14:31:41 -0800
In-Reply-To: <20061115114928.6ff0936e@freekitty> (Stephen Hemminger's message of "Wed, 15 Nov 2006 11:49:28 -0800")
Message-ID: <adalkmcwdde.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 22:31:42.0299 (UTC) FILETIME=[D3027AB0:01C70905]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Are there are any MSI capable devices on non-PCI express?

Yes, e.g. the mthca driver handles PCI-X adapters that do MSI-X.

 - R.
