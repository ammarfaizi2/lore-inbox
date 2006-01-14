Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423085AbWANFNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423085AbWANFNL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423110AbWANFNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:13:11 -0500
Received: from relay4.usu.ru ([194.226.235.39]:38366 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1423085AbWANFNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:13:09 -0500
Message-ID: <43C88898.10900@ums.usu.ru>
Date: Sat, 14 Jan 2006 10:14:00 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg K-H <greg@kroah.com>
Cc: kay.sievers@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
References: <11371818082670@kroah.com> <11371818084013@kroah.com>
In-Reply-To: <11371818084013@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.122; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> [PATCH] INPUT: add MODALIAS to the event environment
> 
> input: add MODALIAS to the event environment

Could you please tell me sample modaliases for a number of "common" 
devices (like a PS/2 mouse)?

I ask because earlier (namely, in 
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/old/gregkh-all-2.6.15.patch) 
such modaliases contained commas (",") and comma is not a "trusted" 
character in Udev (see replace_untrusted_chars() in 
udev_utils_string.c). Thus, such modaliases were mangled and didn't work.

-- 
Alexander E. Patrakov
