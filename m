Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUFGOJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUFGOJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUFGOJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:09:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264653AbUFGOFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:05:54 -0400
Message-ID: <40C47635.4090302@pobox.com>
Date: Mon, 07 Jun 2004 10:05:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       perex@suse.cz, torvalds@osdl.org
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>	<40C107D2.9030301@pobox.com>	<s5hekor4i2c.wl@alsa2.suse.de>	<40C471FC.3000802@pobox.com> <s5h7juj4gio.wl@alsa2.suse.de>
In-Reply-To: <s5h7juj4gio.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> They're nice but they don't provide "cast checking", no?
> The main purpose of the magic_* stuffs in ALSA is to check the cast of
> the void pointer back to the original data type, which the compiler
> can't check.

Sure -- and that magic cast stuff is horribly bloated, and not needed in 
good code.

No other code in Linux does this -- therefore it should be removed.

	Jeff




