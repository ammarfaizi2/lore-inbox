Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVBOOIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVBOOIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVBOOIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:08:46 -0500
Received: from smtpout16.mailhost.ntl.com ([212.250.162.16]:30540 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261727AbVBOOIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:08:38 -0500
Subject: Re: What is the purpose of a GPIO controller
From: Ian Campbell <ijc@hellion.org.uk>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4211FDFC.3040905@globaledgesoft.com>
References: <4211FDFC.3040905@globaledgesoft.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 14:08:33 +0000
Message-Id: <1108476513.3324.10.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 19:19 +0530, krishna wrote:
>     Can any one tell me what is the purpose of GPIO controllers.

I'm not sure what question you are asking... GPIO controllers are
clearly for the purpose of controlling GPIO pins. GPIO stands for
general purpose i/o, so they are used for all sorts of things.

For example, hardware designers hook up all sorts of things to GPIO
lines: input switches, reset lines to other chips on the board, leds,
relays. I have boards where an i2c bus has been constructed using 2 gpio
lines, another gpio is used to control the LCD backlight, etc, etc.

Ian.

-- 
Ian Campbell
Current Noise: Opeth - To Rid the Disease

The pollution's at that awkward stage.  Too thick to navigate and too
thin to cultivate.
		-- Doug Sneyd

