Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSLYPaw>; Wed, 25 Dec 2002 10:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSLYPaw>; Wed, 25 Dec 2002 10:30:52 -0500
Received: from msg.vodafone.pt ([212.18.167.162]:33130 "EHLO msg.vodafone.pt")
	by vger.kernel.org with ESMTP id <S262089AbSLYPav>;
	Wed, 25 Dec 2002 10:30:51 -0500
Date: Wed, 25 Dec 2002 15:40:11 +0000
From: "Paulo Andre'" <fscked@netvisao.pt>
To: linux-kernel@vger.kernel.org
Subject: DRM support causes undesired X behaviour
Message-Id: <20021225154011.1b2e7ecc.fscked@netvisao.pt>
Organization: Orion Enterprises
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Dec 2002 15:38:22.0546 (UTC) FILETIME=[A835BB20:01C2AC2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First things first so merry christmas and a happy new year to you all.

So, I've got a Fujitsu E-7110 laptop with 512MB RAM and a P4 running at 2Ghz
with an ATI Mobility Radeon 7500 and I've noticed that for every kernel I try
(be it 2.4.x or 2.5.x) enabling the DRM support (with the proper ATI Radeon
driver) causes X to lock hard when switching from console to X. The way to
reproduce this is to get into an X session, then using CTRL+ALT+Fn to switch to
some virtual console and when coming back to X with CTRL+ALT+F7 it shows X again
but the image is crippled with some noise and completely frozen. Only thing I
can do, from the machine in question, is to hit CTRL+ALT+DEL and it'll reboot
just like I was still in the console.

Disabling DRM support makes this problem go away and allows me to properly
switch between console and X. I don't know if this is the right place but sounds
like something the DRM people should know of. Feel free to ask for any
configuration details.

Regards,

		Paulo Andre'
