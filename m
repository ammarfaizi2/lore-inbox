Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSIEH4D>; Thu, 5 Sep 2002 03:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSIEH4C>; Thu, 5 Sep 2002 03:56:02 -0400
Received: from [64.6.248.2] ([64.6.248.2]:19880 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S317269AbSIEH4C>;
	Thu, 5 Sep 2002 03:56:02 -0400
Date: Thu, 5 Sep 2002 01:00:33 -0700 (PDT)
From: Peter <cogweb@cogweb.net>
X-X-Sender: cogweb@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
In-Reply-To: <Pine.LNX.4.44.0209032237460.25475-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0209050025460.14137-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>No, because it works just fine when you build the USB drivers as
>modules, and the Input core as modules, which is what the majority of
>people do.

In that case, let's add this to the help screens for the three device
types (CONFIG_INPUT_KEYBDEV, CONFIG_INPUT_MOUSEDEV, CONFIG_INPUT_JOYDEV), 
after the current text:

For the drivers to link correctly, you must make the same selection (Y or
M) here as for the USB Human Interface Device (full HID) support.

Under CONFIG_USB_HID, likewise add after the current text:

For the drivers to link correctly, you must make the same selection (Y or
M) here as for Input core support.

That said, I suggest that Input core support menu be moved into the USB
support menu, where these dependency relations can be automated and made 
visible to the user. 

I apologize for not submitting a patch -- it's a skill I lack.

Cheers,
Peter.



