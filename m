Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTHTWnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbTHTWnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:43:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8606 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262301AbTHTWnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:43:04 -0400
Date: Wed, 20 Aug 2003 15:35:48 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][2.4 PATCH] source address selection for ARP requests
Message-Id: <20030820153548.60e0cbd8.davem@redhat.com>
In-Reply-To: <20030820222710.GC734@alpha.home.local>
References: <1061320363.3744.14.camel@athena.fprintf.net>
	<Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com>
	<20030820100044.3127d612.davem@redhat.com>
	<3F43B389.5060602@candelatech.com>
	<20030820104831.6235f3b9.davem@redhat.com>
	<20030820213443.GA23939@alpha.home.local>
	<20030820144711.13ea5f38.davem@redhat.com>
	<20030820222710.GC734@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 00:27:10 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> +	if (in_dev == NULL)
> +		in_dev_put(in_dev);

What the heck is this? :-)
