Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUC0Tzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUC0Tzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 14:55:40 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:57604 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261866AbUC0Tzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 14:55:38 -0500
Date: Sat, 27 Mar 2004 20:55:35 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
Message-ID: <20040327195535.GA11610@wsdw14.win.tue.nl>
References: <1079446776784@twilight.ucw.cz> <10794467761141@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10794467761141@twilight.ucw.cz>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 03:19:36PM +0100, Vojtech Pavlik wrote:

>   input: Add support for scroll wheel on MS Office and similar keyboards.

> +static unsigned char atkbd_scroll_keys[5][2] = {
> +	{ ATKBD_SCR_1,     0x45 },
> +	{ ATKBD_SCR_2,     0x29 },
> +	{ ATKBD_SCR_4,     0x36 },
> +	{ ATKBD_SCR_8,     0x27 },
> +	{ ATKBD_SCR_CLICK, 0x60 },
> +};

Hi Vojtech,

Can you tell me what keyboard model uses these codes?
(I have different codes for the scroll wheel on certain MS Office
keyboards. See also somewhere below
http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html#ss5.4 )

Apart from this concrete question - the number of keyboards and
mice is very large and growing by the day. I think it is hopeless
to try and teach the kernel about all details of each of them.
I think we should try to go for a keyboard/mouse definition file
maintained in user space and fed to the kernel.

Andries
