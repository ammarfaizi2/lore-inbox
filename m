Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUL0Bkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUL0Bkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUL0Bkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:40:49 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:25590 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261662AbUL0Bkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:40:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rTkWrXAHvjp3MfDbW6D5B+fDsnTF4IB1oSui0+0y1uBK96D4WBgSIFHBBy8rZwHbljOzAjIafI6EG/yDHEqu79BpYI8n+W1OVjnTi5V8lXT19w2RNV4Txl/MSQdjlKO3tiOBe3Ya0T0/2KtY0hGdoTAbl9isG46p9PWhkFyouvM=
Message-ID: <58cb370e041226174019e75e23@mail.gmail.com>
Date: Mon, 27 Dec 2004 02:40:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Linux 2.6.10-ac1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41CF649E.20409@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 02:25:50 +0100, Andreas Steinmetz <ast@domdv.de> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > What do you need 'serialize' option for?
> 
> I didn't check if the problem is gone with 2.6.10 but there's boards
> like my tyan 2885 which do need the serialize option to work properly
> for add-on ide controllers.
> 
>  From the X86-64 patch release notes of Andi Kleen:
> 
> Reports that dual Tyan S2885 and S2880 can lock up when multiple IDE
> channels are stressed in parallel. "noapic" or "ideX=serialize" seems to
> work around it. Andre Hedrick thinks it's a generic bug/race in the IDE
> code.
>
> Do you want to force people to disable the io-apic just because of
> option removal? In my case the serialized devices are a disk and a
> dvd-rw which is rarely used, so disabling the io-apic is a bad solution.

No, I want them to fix the problem - whenever it is - ide or apic code. :)
