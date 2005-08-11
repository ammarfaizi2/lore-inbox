Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVHKTI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVHKTI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVHKTI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:08:57 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:11144 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932372AbVHKTI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:08:57 -0400
Message-ID: <42FBA220.8020508@gmail.com>
Date: Thu, 11 Aug 2005 21:08:16 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Masoud Sharbiani <masouds@masoud.ir>
CC: linux-kernel@vger.kernel.org
Subject: Re: System shutdown with during reboot with 2.6.13-pre6
References: <42FB89D1.1060007@masoud.ir>
In-Reply-To: <42FB89D1.1060007@masoud.ir>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masoud Sharbiani napsal(a):

> Hello,
> Whenever I reboot my Linux machine it turns itself off in the end, 
> unless I add the 'acpi=off' to the end of kernel command line on boot.
> Apparently, it happens after unmounting filesystems as it doesn't do 
> fsck after next power-up.
> ----
> Any ideas?

Try to change reboot behavior to warm, see 
Documentation/kernel-parametres.txt, reboot.
