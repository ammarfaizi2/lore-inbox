Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUGNPzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUGNPzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUGNPzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:55:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8100 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267421AbUGNPz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:55:28 -0400
Message-ID: <40F55763.4080600@pobox.com>
Date: Wed, 14 Jul 2004 11:55:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Genady Okrain <mafteah@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Can't compile sg.c 2.6.8-rc1-mm1
References: <30a4d01b04071401457267defa@mail.gmail.com>
In-Reply-To: <30a4d01b04071401457267defa@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Genady Okrain wrote:
> I am using gcc-3.4.1
> 
>   CC [M]  drivers/scsi/sg.o
> drivers/scsi/sg.c: In function `sg_ioctl':
> drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call
> to 'sg_jif_to_ms': function body not available
> drivers/scsi/sg.c:930: sorry, unimplemented: called from here
> make[2]: *** [drivers/scsi/sg.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2


Looks like a compiler bug.

	Jeff


