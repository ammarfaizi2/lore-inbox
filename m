Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTGRHz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271112AbTGRHz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:55:26 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:2830 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268160AbTGRHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:55:26 -0400
Date: Fri, 18 Jul 2003 09:10:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030718091018.A16388@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Mike Fedyk <mfedyk@matchmail.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <3F170D0F.7070304@pobox.com> <20030717211623.GA2289@matchmail.com> <3F1713E5.6020206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F1713E5.6020206@pobox.com>; from jgarzik@pobox.com on Thu, Jul 17, 2003 at 05:23:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 05:23:49PM -0400, Jeff Garzik wrote:
> Even though net devices are independently refcounted and internally 
> consistent, I have no idea if the module's code is refcounted elsewhere 
> or not.  So, I hope it's safe...

With the rmmod -a cronjobs some people like to run it'll break horribly :)

