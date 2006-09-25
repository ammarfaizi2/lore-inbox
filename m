Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbWIYBYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWIYBYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWIYBYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:24:10 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:57795 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751802AbWIYBYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:24:08 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jeff Garzik <jeff@garzik.org>
Cc: Grant Coady <gcoady.lk@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 make oldconfig missed SATA
Date: Mon, 25 Sep 2006 11:24:01 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <2pbeh2punonnm4gsj8ft71nkagh5120gus@4ax.com>
References: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com> <45171EDA.1040602@garzik.org>
In-Reply-To: <45171EDA.1040602@garzik.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 20:12:10 -0400, Jeff Garzik <jeff@garzik.org> wrote:

>Grant Coady wrote:
>> 2.6.18-mm1 make oldconfig didn't pull SATA config from 2.6.18 old screen to 
>> the new libata screen, caught me out -- this may be an issue for 2.6.19 
>> upgraders that a quick make oldconfig rebuild will fail to boot?
>
>The symbols changed.  No facility for upgrading .config symbols... 
>people who config their own kernels are expected to handle such things...

Oh sure, way back I used to run `make oldconfig; make menuconfig` and check 
the config -- I guess complacency sets in and it is a ((Surprise!))

Grant.
