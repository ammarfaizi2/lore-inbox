Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVKNQUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVKNQUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 11:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKNQUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 11:20:36 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:50327 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751177AbVKNQUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 11:20:36 -0500
Message-ID: <4378B94D.2090305@rtr.ca>
Date: Mon, 14 Nov 2005 11:20:29 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Mario \"Ldonesty\" Di Nitto" <jorge78@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel Sata controller and DVD-RW
References: <200511141712.12763.jorge78@inwind.it>
In-Reply-To: <200511141712.12763.jorge78@inwind.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

libata.atapi_enabled=1  in /boot/grub/menu.lst,

or this line in /etc/modprobe.conf:

options libata atapi_enabled=1
