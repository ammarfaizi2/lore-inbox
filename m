Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUDLKZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDLKZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:25:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:39671 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262774AbUDLKZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:25:41 -0400
Message-ID: <407A6EB3.7080608@onlinehome.de>
Date: Mon, 12 Apr 2004 12:25:55 +0200
From: Mathias Peters <empy@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: problems getting the modules in the right order
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:daf03fd6329e0ac81f958414b71043cb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi to everybody,

i have a problem getting the modules in the right order to boot up 
properly. I have a thinkpad r40 with a ati radeon 5600 mobility. The 
agpgart-driver is compiled within the kernel, while the other drivers 
are compiled as modules(ati-agp, radeon, radeonfb). 'lsmod' shows that 
all these modules are loaded, but X is not starting from kdm after boot 
up. 'dmesg' produces "[drm radeon_cp_init] *ERROR* radeon_cp_init called 
without lock held". when i log in at console and type 'startx' it is 
working...
Has anyone experiencend these problems himself???
thank you
Mathias Peters
