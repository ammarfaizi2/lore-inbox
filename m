Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTFOXRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFOXRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 19:17:14 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:14746 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S262942AbTFOXRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 19:17:13 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: sumit_uconn@lycos.com
Subject: Re: Null Pointer Error
Date: Sun, 15 Jun 2003 20:36:20 -0300
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <NAOFEAJEJJGBLFAA@mailcity.com>
In-Reply-To: <NAOFEAJEJJGBLFAA@mailcity.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306152036.20882.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

A few days ago a similar question arrived to this list (as usual, this is a 
frequently asked question), and Richard B. Johnson replyied with a very good 
explanation of why operations such as these should be done in userland 
instead.
You can read it here: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=105551176615876&w=2

Regards,
Lucas


On Sunday 15 June 2003 20:09, Sumit Narayan wrote:
> Hi,
>
> I am trying to write to a function in the kernel which could create a file
> and add data to it. I am unable to do it, as I am getting Null Pointer
> Error. I am using threads for this. I dont know if I am going right. Could
> someone help me with this. How do I write a function in the kernel which
> could create a file, and write data to it. Somehow, sys_open and sys_read
> are not working. I think I am doing some mistake somewhere. Please help me.
> Thanks in advance.
>
> Sumit
>
>
> ____________________________________________________________
> Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
> http://login.mail.lycos.com/r/referral?aid=27005
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

