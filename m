Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUK2QOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUK2QOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUK2QOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:14:43 -0500
Received: from web60407.mail.yahoo.com ([216.109.118.190]:31361 "HELO
	web60407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261744AbUK2QOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:14:42 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=qj9ToJ/om6tbHkQ6l8fpAsaLlYm62cqNMhhC1eQVTV0taARmf/wbOMwAFu1UlvQB51sDR3NH5qqeUorBigC0p6fMtyAIdPe8Exg8nVV8aEbwbwtcA7bE3sB60RbBIrWsqVCqhyXHIfrZDUu57BT2+aQ3be8i77YiLcZigetZUU4=  ;
Message-ID: <20041129161438.12271.qmail@web60407.mail.yahoo.com>
Date: Mon, 29 Nov 2004 08:14:38 -0800 (PST)
From: Pete Zaitcev <zaitcev@yahoo.com>
Subject: Re: [2.6 patch] drivers/block/ub.c: make a struct static
To: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20041129123729.GQ9722@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -struct usb_driver ub_driver = {
> +static struct usb_driver ub_driver = {
>  	.owner =	THIS_MODULE,

I'm pretty sure it was in the Greg's tree for a while. I have it, too.
Just waiting for a turnaround.

-- Pete



	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
