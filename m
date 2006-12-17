Return-Path: <linux-kernel-owner+w=401wt.eu-S1751830AbWLQUvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWLQUvH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWLQUvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 15:51:06 -0500
Received: from homer.mvista.com ([63.81.120.155]:42839 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823AbWLQUvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 15:51:05 -0500
Message-ID: <4585AE0E.4000607@ru.mvista.com>
Date: Sun, 17 Dec 2006 23:52:30 +0300
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

> This patch makes the needlessly global init_hwif_tc86c001() static.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

    If this patch hasn't been accepted by Andrew yet, could you add another 
fixlet: init_chipset_tc86c001() should've been __devinit.  If not or it's 
already accepted, I'll post the patchlet myself later...

WBR, Sergei
