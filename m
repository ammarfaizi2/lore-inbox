Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbTHQMSL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbTHQMSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:18:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45701 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269133AbTHQMSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:18:10 -0400
Date: Sun, 17 Aug 2003 14:16:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Olaf Zaplinski <olaf@zaplinski.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.0-test3 does not mount root fs
Message-ID: <20030817141651.A20799@electric-eye.fr.zoreil.com>
References: <3F3F6E38.9070002@zaplinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3F6E38.9070002@zaplinski.de>; from olaf@zaplinski.de on Sun, Aug 17, 2003 at 01:59:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski <olaf@zaplinski.de> :
[lilo.conf]
> image=/boot/vmlinuz-2.6.0-test3
>          root=/dev/hda3
>          label=2.6.0-test3
>          append="reboot=warm"

Try append="reboot=warm root=303"

>          read-only
> 
> image=/boot/vmlinuz-2.4.20
>          root=/dev/hda3

--
Ueimor
