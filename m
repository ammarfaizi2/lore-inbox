Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUKWTNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUKWTNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUKWTNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:13:23 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:8712 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261448AbUKWTNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:13:07 -0500
Message-ID: <41A38BBE.2030405@tebibyte.org>
Date: Tue, 23 Nov 2004 20:13:02 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org,
       Jan Kara <jack@suse.cz>
Subject: Re: 2.6.10-rc2-mm3 - oops on boot
References: <20041121223929.40e038b2.akpm@osdl.org>	<41A26BD4.8000509@eyal.emu.id.au> <20041122151049.6b9dc575.akpm@osdl.org> <41A33403.70107@tebibyte.org>
In-Reply-To: <41A33403.70107@tebibyte.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Ross escreveu:
> Andrew Morton escreveu:
>> Well devfs has a NULL sb->s_bdev, so the oops is no surprise.  However 
>> I'm a bit surprised that we even got that far into the quota code.
> 
> I'll find out this evening whether it fixes it for me.

It does fix it.

Regards,
Chris R.
