Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVA1Oqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVA1Oqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVA1Oqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:46:50 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:11501 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261430AbVA1Oql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:46:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VLvmMrCPCBJJufepYM56behn9soQ3+DshgX9Y97X1JTEJxeves9qaduDTk/h4kBCsyjWHcbTleN2W2ojb/JI2PtElnrdNZ2mxgAjt1pzynM1oxXKvzEST8noJl9kuNw+RPye+X/PaOq1KxQmjpufanF3So6rwJ1QkzNFC7ZkGnI=
Message-ID: <d120d50005012806467cc5ee03@mail.gmail.com>
Date: Fri, 28 Jan 2005 09:46:41 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: AT keyboard dead on 2.6
Cc: Wiktor <victorjan@poczta.onet.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20050128143121.GB12137@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11F79.3070509@poczta.onet.pl>
	 <d120d500050121074831087013@mail.gmail.com>
	 <41F15307.4030009@poczta.onet.pl>
	 <d120d500050121113867c82596@mail.gmail.com>
	 <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 15:31:21 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Jan 25, 2005 at 08:37:34PM +0100, Wiktor wrote:
> > Hi,
> >
> > here you are gzip-ed dmesg from booting 2.6.8.1 - i've been playing
> > keyboard while booting, maybe interrupt reports will help you. also my
> > .config part follows:
> > CONFIG_INPUT=y
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_SOUND_GAMEPORT=y
> > CONFIG_SERIO=y
> > CONFIG_SERIO_I8042=y
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_KEYBOARD_ATKBD=y
> > no modules or other built-ins. maybe it is some simple way to fall back
> > to old handling mechanism? in my system most of programs (i mean
> > x-server) uses hardware directly (what means uses /dev/ttyS0 as mouse
> > device). i'm grateful for any help.
> 
> This dmesg looks like the keyboard works perfectly OK. Do new lines
> appear in dmesg when you press keys while the system is running?
>

It does no report any IDs but ACKs GETID command. Not very nice...

-- 
Dmitry
