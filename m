Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUDZItS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUDZItS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 04:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUDZItS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 04:49:18 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:52864
	"HELO fargo") by vger.kernel.org with SMTP id S262730AbUDZItN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 04:49:13 -0400
Date: Mon, 26 Apr 2004 10:48:50 +0000
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Benoit Plessis <benoit@plessis.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input system and keycodes > 256
Message-ID: <20040426104850.GA791@fargo>
Mail-Followup-To: Benoit Plessis <benoit@plessis.info>,
	linux-kernel@vger.kernel.org
References: <1082938686.21842.50.camel@osiris.localnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1082938686.21842.50.camel@osiris.localnet.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benoit ;),

> There are two kind of addons keys, some works (scancode in the e0 XX
> form): Email, Prev, Next, Play/Pause, Vol+/-, Mute, ...
>  + some of thoses generate a simple keycode eg 
>      Vol+: 0x73 | 0xf3 (scancodes: 0xe0 0x30 | 0xe0 0xb0)
>  + some doesn't eg:
>      play: 0x00 0x81 0xa4 | 0x80 0x81 0xa4  (scancodes: 0xe0 0x22 | 0xe0
> 0xa2)

You could make them work using the 'setkeycodes' command to configure
the kernel tables, so you can put some setkeycodes lines in your init
scripts to make those extra keys always avaliable on your console.

bye

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
