Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTKQQJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTKQQJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:09:08 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:11708 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262116AbTKQQJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:09:06 -0500
Message-ID: <3FB8F218.30601@nortelnetworks.com>
Date: Mon, 17 Nov 2003 11:06:48 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB8EBC2.1080800@nortelnetworks.com> <3FB8ED91.3050305@backtobasicsmgmt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:

> There is no pivot_root happening here; the kernel creates a ramfs and 
> mounts it on / (as rootfs), then unpacks the initramfs cpio archive into 
> it. After doing a few more steps, it overmounts the real root onto /, 
> making the rootfs filesystem invisible. It is not freed in the current 
> kernels.

Anyone know why it overmounts rather than pivots?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

