Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265648AbUEZQZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUEZQZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265650AbUEZQZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:25:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30928 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265648AbUEZQZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:25:07 -0400
Message-ID: <40B4C4D4.8070100@pobox.com>
Date: Wed, 26 May 2004 12:24:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Jens_K=FCbler?= <cleanerx@au.hadiko.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: nforce2 keeps crashing with 2.4.27pre3
References: <200405261756.35333.cleanerx@au.hadiko.de>
In-Reply-To: <200405261756.35333.cleanerx@au.hadiko.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Kübler wrote:
> Hi
> 
> I have grabbed the latest pre of the kernel and compiled everything. At bootup 
> the nforce2 fixup message appears but as soon as I cause heavy network 
> traffic the system still locks up. 
> I'm using a rtl8169 1Gbit network card which reads data from a 1Gbit connected 
> raid10 so transfer rates can get pretty high (some tests gave me about 70MB/s 
> reading)

Driver bugs...  r8169 needs updating.

	Jeff



