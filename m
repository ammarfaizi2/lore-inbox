Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWAYOWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWAYOWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWAYOWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:22:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6587 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751011AbWAYOWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:22:22 -0500
Date: Wed, 25 Jan 2006 15:20:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Martin Michlmayr <tbm@cyrius.com>, Al Viro <viro@ftp.linux.org.uk>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
In-Reply-To: <200601250004.06543.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0601251520020.31234@yvahk01.tjqt.qr>
References: <20060124181945.GA21955@deprecation.cyrius.com>
 <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com>
 <20060124231409.GA29982@deprecation.cyrius.com> <200601250004.06543.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I guess having input core as a module does not make much sense, so
>we should change CONFIG_INPUT to be boolean _and_ clean up the core
>code removing module unloading support.

Embedded devices with keyboard hotplugging?


Jan Engelhardt
-- 
