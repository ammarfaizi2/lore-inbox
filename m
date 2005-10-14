Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVJNJxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJNJxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVJNJxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:53:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20145 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbVJNJxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:53:33 -0400
Date: Fri, 14 Oct 2005 10:52:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051014095248.GA22670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <gregkh@suse.de>, Dmitry Torokhov <dtor_core@ameritech.net>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
	Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
	linux-kernel@vger.kernel.org
References: <20051013020844.GA31732@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NACK.  The whole point of classes is to have common attributes and
behaviours over a set of devices.  There's much more than the dev
attribute to them.  Please just fix the input code to get their
semantics right instead.
