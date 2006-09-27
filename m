Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965408AbWI0HKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408AbWI0HKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWI0HKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:10:04 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:34129 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932447AbWI0HKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:10:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MO4IFoOkVhdRcXakGqwjYHI/VeK9wo6sTxJ2VvRb6C5/xyvfSfdYd95GL8JR7Dzp8VXZ2yIJyxKrhfBjOMAKoM+ZUlJnDhx5M3Itrtnmei0lT8Q4cafwj43PyWZzbLMghcfemjhRWAEqJf4HEbfD7X+W93yDM57d71KpoWGQm+A=
Message-ID: <a44ae5cd0609270010n43f04a2xb49852d5aeeeda9c@mail.gmail.com>
Date: Wed, 27 Sep 2006 00:10:01 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.18-mm1 -- need to run mkproper? snd_timer: Unknown symbol snd_info_create_module_entry
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I changed my build options and ran "make all install modules
modules_install" and so forth.  Do the unknown symbol messages below
indicate that all dependencies were not rebuilt and I need to run make
mrproper, or is something else going on here?

snd_timer: Unknown symbol snd_verbose_printd
snd_timer: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_register_device

bay: Unknown symbol is_dock_device
bay: Unknown symbol register_hotplug_dock_device
bay: Unknown symbol unregister_hotplug_dock_device
