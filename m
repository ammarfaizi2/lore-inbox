Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWJLR1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWJLR1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWJLR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:27:40 -0400
Received: from colo.elevenwireless.com ([69.30.42.70]:58750 "EHLO
	smtp.elevennetworks.com") by vger.kernel.org with ESMTP
	id S1750778AbWJLR1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:27:39 -0400
Date: Thu, 12 Oct 2006 10:16:59 -0700
From: Greg KH <gregkh@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       mm-commits@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, pbadari@us.ibm.com
Subject: Re: [patch 16/67] jbd: fix commit of ordered data buffers
Message-ID: <20061012171659.GC10816@suse.de>
References: <20061011204756.642936754@quad.kroah.org> <20061011210446.GQ16627@kroah.com> <20061012115538.GJ9495@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012115538.GJ9495@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 01:55:38PM +0200, Jan Kara wrote:
>   Hi,
> 
> > -stable review patch.  If anyone has any objections, please let us know.
>   There does not seem to be any obvious issues with this change and it
> fixes a real BUG happenning during some stress-testing. On the other hand
> the change is kind of intrusive and changes a quite complex code (or
> better said code with complex interactions). So I'm not sure if it really is
> -stable material...

I think it is, as it does fix a real issue, and the same patch is in
mainline now too.

thanks,

greg k-h
