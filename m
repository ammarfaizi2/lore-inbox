Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269976AbUJHNl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269976AbUJHNl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269988AbUJHNl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:41:28 -0400
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:15674 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S269976AbUJHNiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:38:50 -0400
Message-ID: <41669844.1070907@ens-lyon.fr>
Date: Fri, 08 Oct 2004 15:38:12 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from	inside
 kernel
References: <20041008130442.GE5551@lkcl.net> <1097240824.4389.26.camel@lfs.barra.bali>
In-Reply-To: <1097240824.4389.26.camel@lfs.barra.bali>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For every sys_xx there is a do_xx, that can
> be called from inside the kernel.

Well, not every sys_xx, but most of them :)
For example there's no do_epoll_ctl for sys_epoll_ctl.
I requested this one a long time ago but didn't get it.

Regards,

Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
