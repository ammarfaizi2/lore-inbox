Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbULEWK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbULEWK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbULEWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:10:26 -0500
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:9169
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261336AbULEWKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:10:21 -0500
Message-ID: <41B38790.5020105@freemail.hu>
Date: Sun, 05 Dec 2004 23:11:28 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: CD-ROM problem on x86-64
References: <41A84875.2030505@freemail.hu> <20041129175851.0b7ed213.akpm@osdl.org> <41B33B4A.5040104@freemail.hu> <41B3410E.7050000@freemail.hu>
In-Reply-To: <41B3410E.7050000@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi írta:
> Zoltan Boszormenyi írta:
> 
>> I created /mnt/cdrom and
>> tried mounting /dev/hdc there (as root) but the mount hung...
> 
> 
> With this I meant the machine is up and running but the mount process
> is in D state and stays there. dmesg does not show anything about it.
> 
> And there is something else. When I log into GNOME, nautilus doesn't
> come up immediately in neither X as before. After some minutes which
> may be a timeout (or several timeouts) they come up with the chosen
> background image and their icons. I say 'they' because with the
> linuxconsole.sf.net patch it's possible to use several videocards,
> keyboards and mice for different X consoles, and I logged in on both
> consoles.

This was solved by using "elevator=deadline" boot option instead of
"elevator=cfq", both my removables devices are back and nautilus
starts up quickly as before. So these problems were related.

Best regards,
Zoltán Böszörményi
