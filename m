Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSCZWHX>; Tue, 26 Mar 2002 17:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312791AbSCZWHN>; Tue, 26 Mar 2002 17:07:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10438 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312790AbSCZWGy>;
	Tue, 26 Mar 2002 17:06:54 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 22:06:51 GMT
Message-Id: <UTC200203262206.WAA425072.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, wart@softhome.net
Subject: Re: Separate keymaps for separate vt's?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    A couple of non-English users has asked me if there is an ability to
    have different keymaps for different vt's in kernel.
    It seems like kernel keeps just one translation table for all vt's.
    I would be interested in patching console driver to keep separate tables
    for separate vt's (that would allow me to include an ability to load
    different keymaps in next release of Linux Console Tools). Perhaps there
    are some ideas you can give me, or, perhaps, name a current console driver
    maintainer for me to discuss this idea?

Usually, such things can be done without any kernel changes.
It is easy to set things up in such a way that a single keystroke
changes keymap. People wishing to switch between English and
Cyrillic / Arabic / Greek / ... usually bind the "switch" action
to some key like AltR or Pause or so.
For example, look at cz.map or ua.map (from kbd-1.06).

Andries
