Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUBPMee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 07:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUBPMee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 07:34:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:52427 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265203AbUBPMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 07:34:33 -0500
From: Emmeran Seehuber <rototor@rototor.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Mon, 16 Feb 2004 13:34:43 +0000
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <200402151425.15478.rototor@rototor.de> <200402151028.25284.dtor_core@ameritech.net>
In-Reply-To: <200402151028.25284.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402161334.43583.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 February 2004 15:28, Dmitry Torokhov wrote:
[...]
>
> I see that the kernel correctly identifies both devices so I suspect there
> could be a problem with your setup. Could you also post your XF86Config
> and tell me the the options you are passing to GPM, please?
What I forgot to mention: cat /dev/input/mouse1 gives me some garbage as soon 
as I move on the trackpad. But cat /dev/input/mouse0 gives me nothing, so I 
don't think that this is a userspace configuration problem. The kernel seems 
to get no input from the PS/2 mouse at all.

cu,
  Emmy
