Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUJMGiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUJMGiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUJMGiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:38:13 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:9343 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268483AbUJMGiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:38:11 -0400
Message-ID: <b2fa632f041012233864cc3296@mail.gmail.com>
Date: Wed, 13 Oct 2004 12:08:10 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: eshwar <eshwar@moschip.com>
Subject: Re: Write USB Device Driver entry not called
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
	 <b2fa632f0410122315753f8886@mail.gmail.com>
	 <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 23:22:02 +0530, eshwar <eshwar@moschip.com> wrote:
> Open is sucessfull.... I don't think the problem the flags of open
> 
Try this: open("/dev/usb/dabusb10",O_WRONLY | O_APPEND );

######
raj
######
