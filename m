Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271190AbTGPWza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271193AbTGPWz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:55:29 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:43183 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271190AbTGPWzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:55:23 -0400
Date: Thu, 17 Jul 2003 01:10:08 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030717011008.A32081@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030716225826.GP2412@rdlg.net>; from Robert.L.Harris@rdlg.net on Wed, Jul 16, 2003 at 06:58:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [snip] I just tried to load the emu10k1 which loads without error, but mpg123
> says it can't open the default sound device.

If the module loaded up properly, problem may be in mpg123. If you are using
devfs, try mpg123 -a /dev/sound/dsp . If that works, set up devfsd.

Rudo.
