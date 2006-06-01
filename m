Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWFAWc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWFAWc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWFAWc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:32:26 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:46709 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750822AbWFAWc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:32:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=k7GBXkTwOD5o+slvFaCltyM9GzndmLPInK7VlHKkarrLXzLXdOQ1URXelcAGWx/0fkRxoRIwwNBL2O7gTrFOGPUbGOBvZXJ9qKvVYO0ee9XsdtA8X2ztc/Ze4oYhhnXwcl2bkqk02Ts+0TuVXnI0jhvpNs8wdB5204L5mhYSjY0=
Message-ID: <986ed62e0606011532kdeba801l57c1867c54b2be87@mail.gmail.com>
Date: Thu, 1 Jun 2006 15:32:25 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
X-Google-Sender-Auth: e79fe853a4b44252
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Got a few build warnings with this one :

My build finished; I got this warning during make modules_install:

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.17-rc5-mm2; fi
WARNING: /lib/modules/2.6.17-rc5-mm2/kernel/drivers/scsi/libsrp.ko
needs unknown symbol scsi_tgt_queue_command

-- 
-Barry K. Nathan <barryn@pobox.com>
