Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUC1VRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 16:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUC1VRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 16:17:12 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:24247 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262176AbUC1VRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 16:17:09 -0500
Message-ID: <406740B9.9040409@stesmi.com>
Date: Sun, 28 Mar 2004 23:16:41 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <40667FAB.2090802@stesmi.com> <406734D3.7070501@pobox.com>
In-Reply-To: <406734D3.7070501@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

> SATA ATAPI looks and works just like PATA ATAPI, with one notable 
> exception:  S/ATAPI will include "asynchronous notification", a feature 
> that allows you to eliminate the polling of the cdrom driver that 
> normally occurs.
> 
> You can use ATAPI on SATA today, using a PATA->SATA bridge.  In fact 
> that's the only way I can test SATA ATAPI at all, right now.
> 
> I hope somebody sends me one of these Plextor devices for testing ;-)

Would that mean that one uses the same (sub)drivers as normal SCSI
devices do ?

sd/sg/etc ...

// Stefan
