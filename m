Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265378AbUFBXji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUFBXji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUFBXji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:39:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:25217 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S265378AbUFBXj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:39:27 -0400
Date: Thu, 3 Jun 2004 01:40:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benoit Plessis <benoit@plessis.info>, linux-kernel@vger.kernel.org
Subject: Re: Input system and keycodes > 256
Message-ID: <20040602234054.GB1366@ucw.cz>
References: <1082938686.21842.50.camel@osiris.localnet.fr> <20040426104850.GA791@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040426104850.GA791@fargo>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 10:48:50AM +0000, David Gómez wrote:
> Hi Benoit ;),
> 
> > There are two kind of addons keys, some works (scancode in the e0 XX
> > form): Email, Prev, Next, Play/Pause, Vol+/-, Mute, ...
> >  + some of thoses generate a simple keycode eg 
> >      Vol+: 0x73 | 0xf3 (scancodes: 0xe0 0x30 | 0xe0 0xb0)
> >  + some doesn't eg:
> >      play: 0x00 0x81 0xa4 | 0x80 0x81 0xa4  (scancodes: 0xe0 0x22 | 0xe0
> > 0xa2)
> 
> You could make them work using the 'setkeycodes' command to configure
> the kernel tables, so you can put some setkeycodes lines in your init
> scripts to make those extra keys always avaliable on your console.

Won't work for USB keyboards.

-- 
