Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTLUQcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 11:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLUQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 11:32:18 -0500
Received: from 12-211-69-29.client.attbi.com ([12.211.69.29]:23428 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S263697AbTLUQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 11:32:16 -0500
Message-ID: <3FE5CB0E.6060702@comcast.net>
Date: Sun, 21 Dec 2003 08:32:14 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV32MiRAI5RTH0000f8a2@hotmail.com>
In-Reply-To: <BAY8-DAV32MiRAI5RTH0000f8a2@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicklas Bondesson wrote:
> Nopes, I get the kernel panic before the driver loads or when it does,
> however I'm not seeing any ataraid driver message at all. This is really
> strange I think. The only thing that has changed in my setup are the
> harddrives. I really need to get this working. Do you have any suggestions
> what-so-ever what to do? I really appreciate your help on this.
> 
> /Nicke
> 

Well, since you're using raid1, you should be able to pass a root=/dev/hda1 (or
whatever your / is located) using the same kernel and at least boot using this
kernel. Then maybe you can use dmesg etc.. to see what the driver is actually
doing. From your original post, it looks like you're using Lilo, so you'll need
to boot using the old kernel first and change the lilo entry.

-Walt


