Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSI1Nmh>; Sat, 28 Sep 2002 09:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSI1Nmg>; Sat, 28 Sep 2002 09:42:36 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32783 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261454AbSI1Nmg>;
	Sat, 28 Sep 2002 09:42:36 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put modules into linear mapping 
In-reply-to: Your message of "Fri, 27 Sep 2002 16:09:30 +0200."
             <20020927140930.GA12610@averell> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Sep 2002 23:47:46 +1000
Message-ID: <4287.1033220866@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002 16:09:30 +0200, 
Andi Kleen <ak@muc.de> wrote:
>It has one drawback in that it makes the load address of modules much more
>random than they were previously: you have a bigger chance that 
>the module is loaded somewhere else after reboot and then ksymoops wouldn't
>be able to decode an module oops correctly anymore. With kksymoops this
>shouldn't be a problem anymore, so it can be safely merged.

man insmod.  See 'ksymoops assistance'.  mkdir /var/log/ksymoops.

