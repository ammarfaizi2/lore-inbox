Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUF1IlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUF1IlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUF1IlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:41:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:13789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264895AbUF1IlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:41:07 -0400
Date: Mon, 28 Jun 2004 09:41:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PARCH] driver core: add driver_find to find a driver by name
Message-ID: <20040628084101.GA21636@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <200406272126.05220.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406272126.05220.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 09:26:03PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Here is a patch that adds driver_find() that allows to search for a driver
> on a bus by it's name. The function is similar to device_find already present
> in the tree. I need it for my serio sysfs patches where user can re-bind
> serio port to an alternate driver by echoing driver's name to serio port's
> driver attribute.

It looks like it's missing some refcounting, no?

