Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268894AbTCDAYT>; Mon, 3 Mar 2003 19:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268898AbTCDAYT>; Mon, 3 Mar 2003 19:24:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19974 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268894AbTCDAYR>;
	Mon, 3 Mar 2003 19:24:17 -0500
Message-ID: <3E63F495.5070005@pobox.com>
Date: Mon, 03 Mar 2003 19:34:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@Dell.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
References: <20BF5713E14D5B48AA289F72BD372D6803945AB6-100000@AUSXMPC122.aus.amer.dell.com>
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D6803945AB6-100000@AUSXMPC122.aus.amer.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> Adding IDs to drivers at runtime is definitely a stop-gap measure, and 
> only works when drivers don't need other changes, but it solves an 
> important subset of the problem space.


Agreed on both points -- it's a stopgap measure, and also one that 
happens solve quite a few cases in the field.

Field-replacement of PCI id tables is a todo item for a while now :)

However, anything beyond PCI id table replacement requires code changes 
and recompilation, and that can be handled by existing patch submission 
procedures...

	Jeff



