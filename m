Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTJPKkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTJPKkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:40:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262801AbTJPKkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:40:08 -0400
Message-ID: <3F8E757A.5010008@pobox.com>
Date: Thu, 16 Oct 2003 06:39:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
References: <20031015172030.GA20098@wind.cocodriloo.com> <17122.1066291319@www7.gmx.net>
In-Reply-To: <17122.1066291319@www7.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman wrote:
> I have seen problems like this when a bad driver was spending loads of time
> in it's SA_INTERRUPT (ie meant to be 'fast') IRQ handler ...this buffered up
> *lots * of packets to be handled, and caused this message.
> 
> Perhaps we should profile?


There is no need to profile, I described the problem precisely.

	Jeff



