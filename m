Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUGOTqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUGOTqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUGOTqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:46:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14564 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266306AbUGOTqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:46:31 -0400
Date: Thu, 15 Jul 2004 21:46:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.6 patch] e1000_main.c: fix inline compile errors
Message-ID: <20040715194623.GD25633@fs.tum.de>
References: <20040714210121.GN7308@fs.tum.de> <200407151213.59568.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407151213.59568.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 12:13:59PM +0300, Denis Vlasenko wrote:
>...
> As you go thru them, consider removing inline keyword for
> such large functions.
>...

I did propose this as an alternative approach in the text that 
accopagnied the patch.

My main reason for not directly proposing to remove the inlines was the 
fact that all inline functions were either very small or called only 
once.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

