Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTDJOke (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTDJOke (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:40:34 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:6070 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264058AbTDJOkd (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 10:40:33 -0400
Subject: Re: ATAPI cdrecord issue 2.5.67
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049983308.888.5.camel@gregs>
References: <1049983308.888.5.camel@gregs>
Content-Type: text/plain
Organization: 
Message-Id: <1049986320.599.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 10 Apr 2003 16:52:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 16:01, Grzegorz Jaskiewicz wrote:
> I noticed strange bahavior while truing to record CD using ATAPI on
> 2.5.67 kernel:
> 
> bash-2.05b$ cdrecord -scanbus dev=ATAPI

You must use /dev/hdX device naming convention:

cdrecord --device=/dev/hdd -inq

At least, it works fine for me :-)

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

