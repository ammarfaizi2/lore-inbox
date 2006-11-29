Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967244AbWK2OUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967244AbWK2OUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967246AbWK2OUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:20:47 -0500
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:15793 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S967244AbWK2OUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:20:46 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: make oldconfig problem Re: autoconf.h and auto.conf missing
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <456B6B02.9060105@poczta.fm>
References: <456B6B02.9060105@poczta.fm>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 14:20:41 +0000
Message-Id: <1164810041.13736.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 23:47 +0100, Lukasz Stelmach wrote:
> Greetings.
> 
> It seems that someone has broken *conf programs in 2.6.18 because
> only "make silentoldconfig" recreates autoconf.h and auto.conf
> properly after configuration (.config) has changed.
> 
> I do everything as I always have done.
> 1. create an empty dir and put my current .config there
> 2. make O=dir oldconfig
> 3. compile, everything seems to be OK here
> 4. do some changes to .config and make oldconfig once again
> BZZZZZT

yap I have the same problem 

to workaround I just do make xconfig and click on save.

I like to have some more input about this ....

Thanks, 
> 5. auto.conf and autoconf.h don't change along with .config and when
>  I build the kernel once again new settings don't take effect.
> 
> I discovered I have to make silentoldconfig to regenerate autoconf
> files. However, this *seems* to force rebuilding of all the objects
> instead of, what it has always done, only those that depend on
> altered configurations.
> 
> Has anyone else seen something like this? Is it a bug or a feature?
> 
> Best regards,
> 
> Please CC, I am not a subscriber.

