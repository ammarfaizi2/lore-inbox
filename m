Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbVIORYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbVIORYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbVIORYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:24:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:4791 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030552AbVIORYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:24:54 -0400
Date: Thu, 15 Sep 2005 10:24:32 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, rbh00@utsglobal.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/7] s390: 3270 fullscreen view.
Message-ID: <20050915172432.GA9980@kroah.com>
References: <20050914155345.GA11478@skybase.boeblingen.de.ibm.com> <20050914161022.GA4230@infradead.org> <1126719107.4908.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126719107.4908.29.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 07:31:46PM +0200, Martin Schwidefsky wrote:
> +struct class *class3270;

Isn't this a tty driver already?  If so, you don't need to create your
own class, your devices will just show up in the /sys/class/tty/ area
just fine.

Or am I missing something here?

thanks,

greg k-h
