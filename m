Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbUCLU0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUCLUXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:23:41 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:15365 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262509AbUCLUUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:20:15 -0500
Date: Fri, 12 Mar 2004 20:20:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/10): zfcp log messages part 1.
Message-ID: <20040312202010.B19244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040312193834.GJ2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040312193834.GJ2757@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Fri, Mar 12, 2004 at 08:38:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:38:34PM +0100, Martin Schwidefsky wrote:
> zfcp host adapter log message cleanup part 1:
>  - Shorten log output.
>  - Increase log level for some messages.
>  - Always print leading zeroes for wwpn and fcp-lun.

Is there any reason zfcp can't use dev_printk, sdev_printk & co?

