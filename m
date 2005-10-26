Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVJZRGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVJZRGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVJZRGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:06:17 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:54471 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964823AbVJZRGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:06:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LeT3rdUB5K5XOj8yWepla+mdCtGEMixzess8iMiBIS1fDMAXdJ4zHk69FzM1NtWGffwGh0quagmBB95rFx7BCbEw1C6piSd0M/nX21pom0zsg0+TQKxXMBs99ZdtzJAO+AD8p83YjR4dtQACX0vem5YoUrikwT1vGgb9UsMmP/8=
Message-ID: <4ae3c140510261006q193e466bjc90ace3e7979393c@mail.gmail.com>
Date: Wed, 26 Oct 2005 13:06:16 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: can someone explain how to implement callback in kernel?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a device driver. I want to achieve asynchronous I/O. What
I want to do is as follows:

1. the driver issues a request to the device. Instead of waiting , it
schedules a callback,  then return.

2. after the device serves the request, the callback should be
triggered to finish the rest of work for this request.

This seems to be a standard callback working flow. But I don't know
how to implement this. Can someone give me a brief idea or point me to
some link about this?

Thanks in advance!

Xin
