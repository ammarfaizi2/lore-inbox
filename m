Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSKNXKP>; Thu, 14 Nov 2002 18:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSKNXKP>; Thu, 14 Nov 2002 18:10:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43275 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261839AbSKNXKO>;
	Thu, 14 Nov 2002 18:10:14 -0500
Message-ID: <3DD42EF2.2070902@pobox.com>
Date: Thu, 14 Nov 2002 18:17:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
References: <3DD3FCB3.40506@us.ibm.com> <3DD40719.5030108@pobox.com> <3DD428C3.4030700@us.ibm.com>
In-Reply-To: <3DD3FCB3.40506@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks pretty decent to me...  minor comments:

* might be a good idea to match defaults with the defaults of the normal 
serial console.  IIRC that's 38400,N,8,1.  which brings up a tangent, 
57600 or 115200 is probably preferred these days, but that requires a 
later patch to update serial console and early serial console to be faster

* VGA base might want to be a variable, though I have not convinced 
myself that such is useful

