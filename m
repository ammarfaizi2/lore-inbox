Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTEOQot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTEOQos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:44:48 -0400
Received: from mail.gmx.net ([213.165.65.60]:63427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264106AbTEOQor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:44:47 -0400
Message-ID: <3EC3C6E0.6000300@gmx.net>
Date: Thu, 15 May 2003 18:57:04 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Mark Hindley <mark@hindley.uklinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 oops
References: <20030515070555.GA1589@titan.home.hindley.uklinux.net>
In-Reply-To: <20030515070555.GA1589@titan.home.hindley.uklinux.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley wrote:
> Hi,
> 
> I have been having continual problems with recent kernels
> (2..4.{18,19,20}) locking up. It usually happens at night when the
> machine is idle. Usually the logs are empty. Sys-Rq produces no
> response. The only option is a total reset.
> 
> It has happened again overnight. Looking in the logs, there is an oops
> late yesterday evening, which I hope is the cause and will help this to
> get nailed.
> 
> K6 200. TX motherboard.
> 
> Let me know if you need any more information.

Yes. Do you have APM/ACPI enabled in the kernel? Could you supply your
.config? Have you tried with 2.4.21-rc2?

> May 14 18:22:23 titan kernel: EIP:    0010:[kfree+63/180]    Tainted: P 

Do you have any proprietary modules loaded, and if so, which ones? Can
you reproduce the hang without this module loaded?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

