Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVLIBsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVLIBsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 20:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVLIBsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 20:48:09 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:11526 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750833AbVLIBsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 20:48:08 -0500
In-Reply-To: <loom.20051208T114657-486@post.gmane.org>
References: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org> <Pine.LNX.4.58.0512080044350.28203@shell4.speakeasy.net> <loom.20051208T101830-768@post.gmane.org> <200512081858.08157.chriswhite@gentoo.org> <loom.20051208T114657-486@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11236CA4-1377-4DD2-A0B1-B0C23DB70A4B@oxley.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: Linux Hardware Quality Labs (was: Linux in a binary world... a doomsday scenario)
Date: Fri, 9 Dec 2005 01:48:04 +0000
To: Dirk Steuwer <dirk@steuwer.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> 1)Lets say there is a small licence fee.
> 50% to the developer that writes/intergrates the code into the kernel,
> 50% to the Org that provides the database/legal backup...
>
> or to get things going
> 2)no fees, just providing a certain level of docs
> such that a driver with full hardware support can be created.
> This enables the company to add the "Linux" sticker to their boxes.

If the OEM wants to stick the logo on the box when the hardware ships  
then _they_ will have to write the driver (they can of course  
subcontract to a maintainer if they like).

If they choose to rely on the system where the driver is written by  
somebody who wants to use the hardware themselves then the OEM still  
has to provide the necessary documentation.
And of course they would not be able to use the logo until such time  
as the driver was available.

Documentation must be available for on going maintenance as well as  
initial coding. This would be a requirement for the logo.
Therefore by far the best solution is that the documentation is put  
into the public domain.

If the OEM has a problem with releasing the documentation then they  
would have to enter into some sort of ongoing agreement with the  
certification body to give confidence that the driver was  
maintainable (i.e. ongoing NDA agreement). Without this the hardware  
could not be certified.

I don't know how many drivers are currently provided by the OEM  
rather than written by A. Random Developer, but this process should  
encourage the OEM to provide the driver themselves.
This should reduce the kernel exposure to patent attacks (??). (IANAL)

regards,
Felix
