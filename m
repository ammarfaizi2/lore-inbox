Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVGZK5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVGZK5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVGZK5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:57:08 -0400
Received: from styx.suse.cz ([82.119.242.94]:11411 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261744AbVGZKz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:55:58 -0400
Date: Tue, 26 Jul 2005 12:55:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [INPUT] simple question on driver initialisation.
Message-ID: <20050726105557.GB1588@ucw.cz>
References: <20050726102340.44709.qmail@web25805.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726102340.44709.qmail@web25805.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 12:23:40PM +0200, moreau francis wrote:

> I'm currently developping a very simple driver for a pinpad by using
> Input module. I'm using Event handler to pass events from pinpad to userland.
> In this simple case, I'm wondering if I really need to initialise
> "phys" field in in "input_dev" struct before calling "input_register_device".

Yes, it is required.

> What is this field for ?
 
It is intended for identifying the device based on "location" in the
system.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
