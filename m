Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVA1O2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVA1O2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVA1O2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:28:37 -0500
Received: from styx.suse.cz ([82.119.242.94]:24521 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261411AbVA1O2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:28:13 -0500
Date: Fri, 28 Jan 2005 15:31:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128143121.GB12137@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com> <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F69FFE.2050808@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 08:37:34PM +0100, Wiktor wrote:
> Hi,
> 
> here you are gzip-ed dmesg from booting 2.6.8.1 - i've been playing 
> keyboard while booting, maybe interrupt reports will help you. also my 
> .config part follows:
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> no modules or other built-ins. maybe it is some simple way to fall back 
> to old handling mechanism? in my system most of programs (i mean 
> x-server) uses hardware directly (what means uses /dev/ttyS0 as mouse 
> device). i'm grateful for any help.

This dmesg looks like the keyboard works perfectly OK. Do new lines
appear in dmesg when you press keys while the system is running?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
