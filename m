Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVFUREB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVFUREB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVFUREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:04:01 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:14030 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262147AbVFURCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:02:31 -0400
Message-ID: <42B84820.9010105@ens-lyon.org>
Date: Tue, 21 Jun 2005 19:02:24 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org>	<42B6777F.2050008@ens-lyon.org>	<42B80AB5.7090506@ens-lyon.org> <s5hll53oet1.wl%tiwai@suse.de>
In-Reply-To: <s5hll53oet1.wl%tiwai@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21.06.2005 18:27, Takashi Iwai a écrit :
> Well, this disables the h/w volume controls completely, so it's not a
> generic solution.

Well, I though this wouldn't break anything since HW_INT_ENABLE is not
set there is 2.6.12. Is this a new feature ?

How is this supposed to work ? Does HW_INT_ENABLE in this outw require
some other parts of the git-alsa.patch ?

> Does the patch below have any improvement?

No, same error.

Your second patch gives same error too, but it also made my beeper
generate a very sharp sound during the whole boot.

Actually, I can't test after boot since -mm1 crashes a little bit
later on my laptop. That's why I didn't notice any eventual h/w
volume control breakage with my patch :)
If necessary, I can try with git-alsa.patch applied on top of 2.6.12.

Brice
