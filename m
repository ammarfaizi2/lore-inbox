Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbTGGLzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266942AbTGGLzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:55:11 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:62107 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S266599AbTGGLzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:55:08 -0400
Date: Mon, 7 Jul 2003 14:09:41 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
In-Reply-To: <Pine.LNX.4.40.0307071308310.28730-100000@shannon.math.ku.dk>
Message-ID: <Pine.LNX.4.40.0307071400140.28730-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jul 2003, Peter Berg Larsen wrote:

Replying to myself.

> > button reporting (only left and right as I am not sure to which buttons
> > up/down should be mapped),
>
> hmm. You dont know what the guest protocol, so you can't just | the
> button information. However, reallity is that this will work for nearly
> anybody now.

This is not the greatest idea as the guest sometimes does not recieve the
button release. This is bad only if the userdriver multiplex the
micebuttons from different mice, because it would then seem as the user
holds the button down.


Peter



