Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265191AbSKNUUf>; Thu, 14 Nov 2002 15:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSKNUUf>; Thu, 14 Nov 2002 15:20:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2311 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265191AbSKNUUe>;
	Thu, 14 Nov 2002 15:20:34 -0500
Message-ID: <3DD40719.5030108@pobox.com>
Date: Thu, 14 Nov 2002 15:27:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
References: <3DD3FCB3.40506@us.ibm.com>
In-Reply-To: <3DD3FCB3.40506@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VGA and serial are certainly not hammer+ia32-specific.  Make the generic 
parts generic...   the arch-specific components would need to change 
early-foo base addresses perhaps, but otherwise, it's pretty generic.

	Jeff



