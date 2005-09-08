Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVIHVNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVIHVNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVIHVNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:13:50 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:33825 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751402AbVIHVNu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:13:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dHTDs5GlI58W6V3J5PLa1vvKNOQq7SQWacf9rm9/xu4QG2NfmTO+eLTGKYiV369qQ+c78mw5c0MNJiW8iVkDCUOz+xTULtMLb0XUBCvRammBaxjHPEXX4WqdTgGZ0+8gyvQoIP6l4BHpYWZWF9VF/WRfWukzVemQhCF8+MZdkvo=
Message-ID: <81b0412b05090814132ebe54dd@mail.gmail.com>
Date: Thu, 8 Sep 2005 23:13:12 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic .config generation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050908203957.7463.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050908203957.7463.qmail@web51005.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> I made this Framework to generate a .config based on a
> Target-System. Right-now it works on my Laptop Acer

how about teaching it to generate .config using just sysfs and lsbus?
So noone will need to contact you regarding adding their system to
your files, especially when all the information is already present in
the kernel in a very parsable form (pci.ids, for example).

The whole scenary will then shorten to:
$ make autoconfig
$ make
