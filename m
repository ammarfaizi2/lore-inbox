Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWC3Sgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWC3Sgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWC3Sgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:36:31 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:58779 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbWC3Sga convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:36:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+dw34GSUIh/8lqwkD8VWLyCI6ZsK5v9wzGdkQrTn6ypb8eKNN306EfP77XgumokaHNHVJdCDC4W2LhoeE6er8/8I/QU2BqCbg5RFbEOXVS/kdZOO/Qr4CMnBOk7wui2GFjks2oaRjH/TVNkj7m0xFs/7ZhHZwysgML5picSL0c=
Message-ID: <c0a09e5c0603301036s4e9a63e5v476d89ff8ba37760@mail.gmail.com>
Date: Thu, 30 Mar 2006 10:36:29 -0800
From: "Andrew Grover" <andy.grover@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Cc: "Chris Leech" <christopher.leech@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <8C52750C-8BC3-4815-834C-6DBEA714BA0F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060329225505.25585.30392.stgit@gitlost.site>
	 <20060329225548.25585.73037.stgit@gitlost.site>
	 <8C52750C-8BC3-4815-834C-6DBEA714BA0F@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> What is the utility of exporting memcpy_count, and bytes_transferred
> to userspace via sysfs?  Is this really for debug (and thus should be
> under debugfs?)

Well....it's true they're useful for debugging but I would put them in
the category of system statistics that shouldn't go in debugfs. I
think they are like /proc/interrupts' interrupt counts or the TX/RX
stats reported by ifconfig.

Regards -- Andy
