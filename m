Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWCZHYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWCZHYD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 02:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWCZHYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 02:24:03 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:47896 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbWCZHYC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 02:24:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B6nnp6Y6jckvu8Yc44JSzSaqmaz04gxWF8yTyido9ucmMAY90ON88o8eSvOVOVCYLW6v09laqub5y3qK6hYrdhobdHvrjKcyYX7EwmSq+WsThBlGJgcVclr2uRokLyCpEr5vLub9xoFDD0pgmCGvt7gDv1Px6AUU0I+I8X6sT0o=
Message-ID: <bda6d13a0603252324y3010ff84sdbce2d0aed68bb6e@mail.gmail.com>
Date: Sat, 25 Mar 2006 23:24:01 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual Serial Port
In-Reply-To: <4425FB22.7040405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442582B8.8040403@gmail.com>
	 <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr>
	 <4425FB22.7040405@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> My purpose is to provide serial interfaces for debugging. My real box
> acts as remote host connecting to VMWare box by a *virtual* serial cable
> so that I can set up a debugging environment.
>
[snip]
>
> Mikado

I wonder if either ptyp/ttyp or pts/ interfaces would suit your
purpose. They are
supposed to appear on one side to be virtual serial ports.
