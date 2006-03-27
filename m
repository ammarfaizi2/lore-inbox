Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWC0VLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWC0VLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWC0VLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:11:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:5367 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751433AbWC0VLx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:11:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: jt@hpl.hp.com
Subject: Re: 32bit compat for rtnetlink wireless extensions?
Date: Mon, 27 Mar 2006 23:10:44 +0200
User-Agent: KMail/1.9.1
Cc: netdev@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
References: <200603261408.48766.arnd@arndb.de> <20060327184242.GC31478@bougret.hpl.hp.com>
In-Reply-To: <20060327184242.GC31478@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603272310.44692.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Monday 27 March 2006 20:42 schrieb Jean Tourrilhes:
>         Actually, when things are passed over RtNetlink, the pointer
> is removed, and the content of IW_HEADER_TYPE_POINT is moved to not
> leave a gap.

Ah, that makes sense, thanks for the explanation.

So if the wireless ioctl interface ever got retired, that code could
get simplified a lot to just pass around a flat data structure, right?

	Arnd <><
