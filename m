Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUKUHQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUKUHQp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKUHP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:15:59 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:64904 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261917AbUKUHPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:15:54 -0500
To: arnd@arndb.de
CC: diegocg@gmail.com, linux-kernel@vger.kernel.org
In-reply-to: <200411210314.59537.arnd@arndb.de> (message from Arnd Bergmann on
	Sun, 21 Nov 2004 03:14:58 +0100)
Subject: Re: [PATCH 3/13] Filesystem in Userspace
References: <E1CVeML-0007PA-00@dorka.pomaz.szeredi.hu> <20041121003755.3342a1cb.diegocg@gmail.com> <E1CVfgb-0007Ze-00@dorka.pomaz.szeredi.hu> <200411210314.59537.arnd@arndb.de>
Message-Id: <E1CVlwk-0007pU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 08:15:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But once it is integrated, you can no longer make incompatible changes to
> the API.

Yes, generally backward compatibility is a good thing and I shall try
to follow it as far as I can.

However, FUSE is still young (only 3 years old), and I can imagine,
that there will come a time, (not too often) when it's better to break
the API than to carry a lot of compatibility cruft around.  And in
that case the version is very useful.

Also it's useful to distingush the integrated version from the older
standalone versions.

Thanks,
Miklos
