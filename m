Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTDNVeN (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263739AbTDNVeN (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:34:13 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18953
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263737AbTDNVeM 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:34:12 -0400
Subject: Re: [RFC] /sbin/hotplug multiplexor
From: Robert Love <rml@tech9.net>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <3E9B2720.7020803@cox.net>
References: <20030414190032.GA4459@kroah.com>
	 <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com>
	 <200304142311.01245.oliver@neukum.org>  <3E9B2720.7020803@cox.net>
Content-Type: text/plain
Organization: 
Message-Id: <1050356754.3664.82.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 14 Apr 2003 17:45:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 17:24, Kevin P. Fleming wrote:

> Personally, this is one reason why I'd much rather see a daemon-based model 
> where each interested daemon can "subscribe" to the messages it is interested 
> in. It's very possible (and likely, i.e. udev) that the steps involved for the 
> daemon to respond to the hotplug event are so lightweight that creating a 
> subprocess to handle them would be very wasteful.

This screams for d-bus.

I spent the weekend reading about it and I spoke with some of the d-bus
hackers.

It is really neat and certainly something we should look into.

See http://www.freedesktop.org/software/dbus/

	Robert Love


