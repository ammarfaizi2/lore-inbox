Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWEWW5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWEWW5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWEWW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:57:48 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:22453 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932278AbWEWW5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:57:48 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
Date: Tue, 23 May 2006 23:57:36 +0100
Message-Id: <E1Fifom-0003qk-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:

> 1) Running the video ROM at boot to reset cards, emu86

Jon, how many times am I going to have to tell you that this won't work? 
The video ROM is not always present on laptop hardware, and even when it 
is it may jump into sections of ROM that have vanished since boot. 
In the long run, graphics drivers need to know how to program cards from 
scratch rather than depending on 80x25 text mod being there for them.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
