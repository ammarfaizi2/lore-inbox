Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTDQPuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDQPux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:50:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16327
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261798AbTDQPuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:50:52 -0400
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Patrick Mochel <mochel@osdl.org>, Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304171459.h3HExMBa000217@81-2-122-30.bradfords.org.uk>
References: <200304171459.h3HExMBa000217@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050591871.31390.79.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 16:04:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 15:59, John Bradford wrote:
> The machines are never accessed except over the LAN in normal use, but
> it's quite possible that you'd want to suspend the whole cluster
> overnight, for example, or at least some nodes which were not in use,
> and you wouldn't care about the VGA card being restored.

Fine,. set the "dont post" flag, set the callback to a null function

