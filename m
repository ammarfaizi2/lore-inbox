Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSLAS5j>; Sun, 1 Dec 2002 13:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLAS5j>; Sun, 1 Dec 2002 13:57:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30469 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263366AbSLAS5j>;
	Sun, 1 Dec 2002 13:57:39 -0500
Date: Sun, 1 Dec 2002 12:05:35 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: James Morris <jmorris@intercode.com.au>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021201200535.GA9448@kroah.com>
References: <Mutt.LNX.4.44.0212020441560.19785-100000@blackbird.intercode.com.au> <873cph37dh.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cph37dh.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 07:46:02PM +0100, Olaf Dietsche wrote:
> 
> If you want to check, wether a module has been recompiled, you should
> add a length/sizeof(struct security_operations) parameter.

No, I don't want to go down that path.  All security modules need to be
compiled against the exact kernel version they are going to be used for,
like any other kernel module type.

thanks,

greg k-h
