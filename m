Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755375AbWKNIJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbWKNIJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbWKNIJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:09:34 -0500
Received: from raven.upol.cz ([158.194.120.4]:31624 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1755375AbWKNIJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:09:34 -0500
To: Phil Oester <kernel@linuxace.com>
Subject: Re: make menuconfig regression in 2.6.19-rc
In-Reply-To: <20061114003752.GA15295@linuxace.com>
References: <20061114003752.GA15295@linuxace.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
Organization: Palacky University in Olomouc, experimental physics department.
Date: Tue, 14 Nov 2006 08:16:33 +0000
Message-Id: <E1GjtT7-0002to-LO@flower>
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

Phil Oester wrote:
> In commit 350b5b76384e77bcc58217f00455fdbec5cac594, the default menuconfig
> color scheme was changed to bluetitle.  This breaks the highlighting
> of the selected item for me with TERM=vt100.  The only way I can see
> which item is selected is via:
>
>     make MENUCONFIG_COLOR=mono menuconfig
>
> Which restores the pre-2.6.19 white on black highlighting.  

Classic theme also doesn't work, and this commit doesn't look like
changing anything in it.

Thus, i think, just export variable with working theme (mono) on your
exotic setup.

> Sam?

If you want answer from busy developers, try to add their e-mail next
time.

> Phil
____
