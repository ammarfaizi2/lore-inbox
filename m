Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVLALiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVLALiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVLALiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:38:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3787 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932163AbVLALiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:38:03 -0500
Date: Thu, 1 Dec 2005 11:38:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       zippel@linux-m68k.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 01/43] Move div_long_long_rem out of jiffies.h
Message-ID: <20051201113801.GH3958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org,
	george@mvista.com, johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de> <1133395255.32542.444.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133395255.32542.444.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 01:00:54AM +0100, Thomas Gleixner wrote:
> plain text document attachment
> (move-div-long-long-rem-out-of-jiffiesh.patch)
> 
> - move div_long_long_rem() from jiffies.h into a new calc64.h include file,
>   as it is a general math function useful for other things than the jiffy
>   code.

please just kill it div_long_long_rem()

