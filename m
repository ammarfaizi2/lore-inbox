Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVLMGjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVLMGjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLMGjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:39:54 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:37429 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932355AbVLMGjy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:39:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gZ3usq2LIAt3vRgOPDzI/M7AdudVszzhQEXKxpvC2VVWd9mfitb7TXvgXgbzzAbhiibb9UvtkEv8XG4RGZTsyn1GqyEgVCK/ZCTRUTroCtWFVvWj1WbhDhcXdDvVV7JT6zKrzzHNjCANaVOdskIlWFW7HHUIguBKCNCDKYI7TKI=
Message-ID: <7a37e95e0512122239p34d0f436k30227f7f62a2e437@mail.gmail.com>
Date: Tue, 13 Dec 2005 12:09:53 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: patch for splice system call.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am routing data from a tuner to harddisk.
I came to know splice() is something related to do real-time IO.
I believe direct IO doesn't address this scenario.

Can any one refer me the source to the patch of splice() system call.

Regards,
Deven

On 12/9/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 12/9/05, Deven Balani <devenbalani@gmail.com> wrote:
> > I am writing a libata-complaint SATA driver for an ARM board.
> >
> > I want to do data streaming from a tuner into the SATA hard disk.
> >
> > In other words, I am getting a buffer of stream in kernel space, which
> > I had to store it in SATA hard disk.
>
> can this be of interest:
>
> http://groups.google.de/group/fa.linux.kernel/browse_frm/thread/21b2b3215f35e21a/bcbc00b7a0151afd?tvc=1&q=linux-kernel+Make+pipe+data+structure+be+a+circular+list+of+pages#bcbc00b7a0151afd
>
