Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVEEKKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVEEKKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 06:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVEEKKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 06:10:48 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:10993 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262022AbVEEKKr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 06:10:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJUGpJJeQzjenKcwO/drGofcoU0X6JjyLjNeFOoC1fViFPs4yp5UTdHqRx6yWS5pz4LCJVGmA8goktzKZt4RUkYgnop08Olv+mhywtkWI2+gqOW+FX0TbRkuMlZTOPn/Btqco8WL8nA5QyZHViAwWizCT6hyt7o1ZKMPXgl9Ssw=
Message-ID: <58cb370e050505031041c2c164@mail.gmail.com>
Date: Thu, 5 May 2005 12:10:47 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
In-Reply-To: <20050505004854.GA16550@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050505004854.GA16550@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/05, Wakko Warner <wakko@animx.eu.org> wrote:
> If this interface is obsolete and will be removed, is there any non-obsolete
> way of telling the kernel what geometry I want to use for this ide device?

Yes, physical geometry - through boot parameters and logical geometry
is not needed for IDE layer to function properly.

Bartlomiej
