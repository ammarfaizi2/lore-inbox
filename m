Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVAMRvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVAMRvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVAMRtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:49:06 -0500
Received: from fbxmetz.linbox.com ([81.56.128.63]:9622 "EHLO joebar.metz")
	by vger.kernel.org with ESMTP id S261265AbVAMRJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:09:52 -0500
Message-ID: <41E6AB59.4000808@linbox.com>
Date: Thu, 13 Jan 2005 18:09:45 +0100
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAIT device driver feasibility
References: <41E696F4.3070700@linbox.com> <1105630888.4664.54.camel@localhost.localdomain>
In-Reply-To: <1105630888.4664.54.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-01-13 at 15:42, Ludovic Drolez wrote:
> 
>>RAIT already exists in Amanda, in user space, but I'd like to see a generic 
>>kernel RAIT driver which could be used by any backup program.
> 
> 
> Why kernel space - why not a user space shared library you can add to
> other tape apps?

A shared library which would override read(), write() in the program ? Why not...

But do you think you can chain/bounce, ioctl(), read(), writes from a char 
driver to another ?

Regards,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 50 87 90                            fax : 03 87 75 19 26
