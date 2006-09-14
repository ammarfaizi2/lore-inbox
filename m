Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWINJyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWINJyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWINJyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:54:47 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:54739 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751525AbWINJyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:54:46 -0400
Date: Thu, 14 Sep 2006 18:54:32 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 1/11] LTTng-core 0.5.108 : build
Message-ID: <20060914095432.GA6780@localhost.usen.ad.jp>
References: <20060914034030.GB2194@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914034030.GB2194@Krystal>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 11:40:30PM -0400, Mathieu Desnoyers wrote:
> 1- LTTng menu options and Makefiles
> (do not enable blktrace for now : kernel/relay.o is disabled)

And the rationale behind this would be..?

Apparently you've also decided to try and add the file system back in,
what exactly is so "special" about LTTng that it can't use CONFIG_RELAY
in conjunction with debugfs, in the same way that blktrace does now?
