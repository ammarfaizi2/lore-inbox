Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUICHMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUICHMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269295AbUICHMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:12:54 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:51147
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S269013AbUICHMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:12:52 -0400
Message-ID: <41381972.8080600@bio.ifi.lmu.de>
Date: Fri, 03 Sep 2004 09:12:50 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch
 is this? - Unsure still
References: <200408170349.44626.shawn.starr@rogers.com> <200408170402.33368.shawn.starr@rogers.com> <200408170801.00068.dtor_core@ameritech.net>
In-Reply-To: <200408170801.00068.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Tuesday 17 August 2004 03:02 am, Shawn Starr wrote:
> 
>>Sorry, I stand corrected. I don't know where this patch is added from which 
>>enables the touchpad to act as a 'button press'.
>>
> 
> 
> mousedev now does tap emulation for touchpads working in absolute mode
> (Synaptics) so you don't need to use psmouse.proto= parameter to force
> it in PS/2 compatibility mode. Use mousedev.tap_time= option to control
> it.
> 
> The patch is only in -mm at the moment.

Can that patch be downloaded somewhere to patch against 2.6.8.1? I don't
have any tapping support for my synaptic touchpad on my compaq laptop after
switching from 2.4 to 2.6.
It seems that most of the patches at http://www.geocities.com/dt_or/input/2_6_7/
are already in 2.6.8.1: Just the tapping stuff seems to be missing. And
I can't extract your patch from the 2.6.9-rc1-mm2 stuff, because it seems
to be mixed with some other patches there.
Is there a sole version of this patch fir 2.6.8.1 somewhere?

cu,
Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

