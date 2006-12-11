Return-Path: <linux-kernel-owner+w=401wt.eu-S1763028AbWLKTaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763028AbWLKTaJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763031AbWLKTaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:30:09 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:34524 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763028AbWLKTaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:30:06 -0500
Subject: Re: [PATCH] input/usb: Supporting more keys from the HUT Consumer
	Page
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Festi <ffesti@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457D8E59.2000200@redhat.com>
References: <457D8E59.2000200@redhat.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 20:30:41 +0100
Message-Id: <1165865441.20733.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> On USB keyboards lots of hot/internet keys are not working. This patch 
> adds support for a number of keys from the USB HID Usage Table 
> (http://www.usb.org/developers/devclass_docs/Hut1_12.pdf).
> 
> It also adds several new key codes. Most of them are used on real world 
> keyboards I know. I added some others (KEY_+ EDITOR, GRAPHICSEDITOR, 
> DATABASE, NEWS, VOICEMAIL, VIDEOPHONE) to avoid "holes".
> 
> I would be interested in comments to the "zoom" key. For me it looks 
> like KEY_ZOOM is on a remote control for a DVD player or something 
> similar. So it toggles between a few zoom levels. The Zoom 100% key 
> found on keyboards (some Logitech internet keyboards for example) resets 
> the Zoom to 100%. May be we need another keycode for them. Additionally
> does the USB HUT define the Zoom entry as "linear control" but the 
> logitech uses it as Zoom 100% key.

we just split the HID parser from the actual USB transport driver and it
seems your patch is against an old tree. Please update your patch.

Regards

Marcel


