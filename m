Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759737AbWLDIyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759737AbWLDIyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759752AbWLDIyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:54:19 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:51911 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1759735AbWLDIyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:54:18 -0500
Subject: Re: [RFC] rfkill - Add support for input key to control wireless
	radio
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Williams <dcbw@redhat.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, Dmitry Torokhov <dtor@insightbb.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Jiri Benc <jbenc@suse.cz>,
       Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>, davidz@redhat.com,
       Bastien Nocera <bnocera@redhat.com>
In-Reply-To: <1165175065.3178.10.camel@localhost.localdomain>
References: <200612031936.34343.IvDoorn@gmail.com>
	 <1165175065.3178.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 09:53:43 +0100
Message-Id: <1165222423.12640.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> 3) How does this interact with HAL?  What's the userspace interface that
> HAL will listen to to receive the signals?  NetworkManager will need to
> listen to HAL for these, as rfkill switches are one big thing that NM
> does not handle now due to lack of a standard mechanism.
> 
> In any case, any movement on rfkill interface/handling standardization
> is quite welcome :)

I want some handling for the Bluetooth rfkill in HAL, so our config
application can physically turn on/off the Bluetooth chip with a simple
method call to the HAL D-Bus interface. We also need to discover the
existence of such a rfkill switch.

Regards

Marcel


