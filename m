Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTFPUjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFPUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:39:52 -0400
Received: from ns.suse.de ([213.95.15.193]:26884 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264271AbTFPUjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:39:51 -0400
Date: Mon, 16 Jun 2003 22:53:42 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: janiceg@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       stekloff@us.ibm.com, girouard@us.ibm.com, lkessler@us.ibm.com,
       kenistonj@us.ibm.com, jgarzik@pobox.com
Subject: Re: patch for common networking error messages
Message-ID: <20030616205342.GH30400@wotan.suse.de>
References: <3EEE28DE.6040808@us.ibm.com> <20030616.133841.35533284.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616.133841.35533284.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 01:38:41PM -0700, David S. Miller wrote:
>    From: Janice M Girouard <janiceg@us.ibm.com>
>    Date: Mon, 16 Jun 2003 15:30:22 -0500
> 
>    EMSG_NET_LINK_UP     "%s: state change: link up, %d Mbps, %s-duplex\n"
> 
> Should indicate flow control state too.

It would be actually useful  to wrap these in real functions.

Why? It will make supporting netconsole easier which has to be careful
to never recurse in the network driver.

-Andi

