Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUJDSBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUJDSBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUJDSBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:01:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268342AbUJDSBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:01:43 -0400
Message-ID: <41618FF9.7080801@pobox.com>
Date: Mon, 04 Oct 2004 14:01:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Knop <wknop@andrew.cmu.edu>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu> <41617AA0.9020809@pobox.com> <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
In-Reply-To: <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Knop wrote:
> 
> I just got another oops while trying to cp from my md/raid5 array (2 of 
> 3 sata drives) to another sata drive on the same controller. This time, 
> though, it said there's a bug in timer.c, line 405, and that the stack's 
> garbage. I'm thinking it has nothing to do with timer.c, and something 
> in md or libata is chomping all over the kernel.

If you are getting random oopses all over the place, I would suspect 
hardware before I suspect buggy code.

Jim's, and others' suggestions were good:  check power connectors (not 
just overall power consumption), test CPU, RAM, temperature, ...

	Jeff



