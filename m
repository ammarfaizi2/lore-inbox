Return-Path: <linux-kernel-owner+w=401wt.eu-S932232AbWLQSHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWLQSHT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWLQSHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:07:19 -0500
Received: from homer.mvista.com ([63.81.120.155]:42439 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932232AbWLQSHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:07:17 -0500
Message-ID: <458587AB.5000108@ru.mvista.com>
Date: Sun, 17 Dec 2006 21:08:43 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org
Subject: Re: [-mm patch] drivers/ide/pci/tc86c001.c: make a function static
References: <20061214225913.3338f677.akpm@osdl.org> <20061216135650.GA3388@stusta.de>
In-Reply-To: <20061216135650.GA3388@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Adrian Bunk wrote:

>>+toshiba-tc86c001-ide-driver-take-2.patch

> This patch makes the needlessly global init_hwif_tc86c001() static.

    Duh, I hoped tha this driver may get into 2.6.20-rc1 and finally 
overlooked this. Sigh, uou won't believe how much time this driver rewrite 
spent in an unfinished state in my internal tree... :-/

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> BTW:
> I'm not sure whether it'd be a good idea to include such a driver for 
> the legacy IDE subsystem without a libata based driver for the same 
> hardware.

    Well, I'd agree with Alan here. Don't expect me to convert this to libata 
in the foreseeable future... I'd like to join the folks hacking on libata but 
this certainly won't happen soon (if at all)...

WBR, Sergei
