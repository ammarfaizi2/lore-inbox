Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVAJUkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVAJUkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVAJUiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:38:00 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:50611 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262529AbVAJUdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:33:08 -0500
To: Brice.Goglin@ens-lyon.org
CC: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <41E2E276.1070309@ens-lyon.fr> (message from Brice Goglin on Mon,
	10 Jan 2005 21:15:50 +0100)
Subject: Re: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes
References: <E1Co4iU-00043y-00@dorka.pomaz.szeredi.hu> <41E2E276.1070309@ens-lyon.fr>
Message-Id: <E1Co6DZ-0004Kx-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 21:32:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +config FUSE
> > +	tristate "Filesystem in Userspace support"
> 
>  From what I see in my .config, most file systems have their config option
> named CONFIG_FOO_FS. Why wouldn't FUSE follow this model ?

It does.  CONFIG_ is prepended by make config.

Miklos
