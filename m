Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUJDQzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUJDQzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUJDQzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:55:17 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:25236 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268271AbUJDQzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:55:11 -0400
Date: Mon, 4 Oct 2004 12:55:10 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <41617AA0.9020809@pobox.com>
Message-ID: <Pine.LNX.4.60-041.0410041241540.9105@unix43.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <41617AA0.9020809@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It either smells like a hardware problem or a raid problem.  The oops you 
> list here is in raid5 not libata.

I'm inclined to agree. I should have titled the thread "libata/md badness" 
since it appears to be a raid atop sata issue. Raid5 apparently works over 
scsi, though.

This is really beyond my realm of knowledge, though. After I check my 
drives for errors, I'm going to back up my array and then experiment a 
bit. I'll post any oopses I find in hopes that someone will be able to 
properly interpret them.

Will
