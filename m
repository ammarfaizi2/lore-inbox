Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVBBGHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVBBGHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 01:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVBBGHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 01:07:16 -0500
Received: from smtp07.web.de ([217.72.192.225]:64217 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S261438AbVBBGHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 01:07:04 -0500
Message-ID: <42006E79.7070503@web.de>
Date: Wed, 02 Feb 2005 07:08:57 +0100
From: Victor Hahn <victorhahn@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Really annoying bug in the mouse driver
References: <41E91795.9060609@web.de> <d120d5000502010556629fdb48@mail.gmail.com> <41FF9001.5090607@web.de> <200502011819.12304.dtor_core@ameritech.net>
In-Reply-To: <200502011819.12304.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>Any luck with the patch?
>

I'm using 2.6.11rc2 with the patch for some hours now and it seems as if 
it doesn't throw away bytes any more which makes linux 2.6 useable for 
me again - thanks a lot! I just encountered one smaller issue (this 
really is much better than before): The mouse just "jumped" once and 
then got back to normal immediately. This gives me the following message 
in /var/log/messages:

kernel: psmouse.c: bad data from KBC - bad parity

Any idea about this?

Regards,
Victor
