Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132869AbRDPGyr>; Mon, 16 Apr 2001 02:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDPGyh>; Mon, 16 Apr 2001 02:54:37 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:37126 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132867AbRDPGyZ>;
	Mon, 16 Apr 2001 02:54:25 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104160654.f3G6sHu477292@saturn.cs.uml.edu>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 16 Apr 2001 02:54:17 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9b83i5$ha7$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 13, 2001 04:53:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> This means you don't have to configure two levels (scancodes ->
> keycodes and keycodes -> keymap); since currently the keycodes are
> keyboard-specific anyway there is no benefit to the two levels.

The medium-raw level ought to be what the X11R6 protocol uses.
Then the keyboard-specific stuff can be removed from XFree86,
and there would be one less mapping to configure.
