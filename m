Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270709AbRHKDl2>; Fri, 10 Aug 2001 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270710AbRHKDlS>; Fri, 10 Aug 2001 23:41:18 -0400
Received: from zero.tech9.net ([209.61.188.187]:36872 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S270709AbRHKDlH>;
	Fri, 10 Aug 2001 23:41:07 -0400
Subject: Re: [PATCH] 2.4.7-ac11: Updated emu10k1 driver
From: Robert Love <rml@tech9.net>
To: John Cavan <johnc@damncats.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B74A69D.214B4232@damncats.org>
In-Reply-To: <997485043.692.23.camel@phantasy>
	<997496304.898.82.camel@phantasy>  <3B74A69D.214B4232@damncats.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 10 Aug 2001 23:42:02 -0400
Message-Id: <997501334.7306.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Aug 2001 23:29:33 -0400, John Cavan wrote:
> It doesn't build. The module stuff in joystick.c conflicts with main.c
> during linking, you sort of have to decide whether or not the joystick
> port driver is seperate or is a part of the entire emu10k1 module. By
> the way, is the joystick port driver intended to replace the one
> selected under the character devices -> joystick selection?

hm, edit drivers/sound/emu10k1/Makefile and remove the object reference
for `joystick.o' -- i dont compile as a module so i missed this, thanks.

and then enable the joystick under character devices -> joysticks

i have updated the patches to release 3:
http://tech9.net/rml/linux/patch-rml-2.4.7-ac11-emu10k1-3
and
http://tech9.net/rml/linux/patch-rml-2.4.7-emu10k1-3

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

