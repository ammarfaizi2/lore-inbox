Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUAEGEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUAEGEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:04:53 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:53866 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265715AbUAEGEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:04:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: New set of input patches
Date: Mon, 5 Jan 2004 00:59:24 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net>
In-Reply-To: <200401030350.43437.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401050059.25031.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made 3 more input patches:

- compile fix in 98busmose driver (it still had its interrupt routine
  returning voooid instead of irqreturn_t)
- the rest of mouse devices converted to the new way of handling kernel
  parameters and document them in kernel-parametes.txt
- convert tsdev module to the new way of handling kernel parameters and
  document them in kernle-parameters.txt.

The patches can be found at the following addresses:
http://www.geocities.com/dt_or/input/2_6_1-rc1/
http://www.geocities.com/dt_or/input/2_6_1-rc1-mm1/

Vojtech, Andrew,

are you interested in these kind of patches and should I take a stab at
converting joysticks diectory as well?

Dmitry
