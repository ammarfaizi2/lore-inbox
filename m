Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272236AbTHRSyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272238AbTHRSyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:54:07 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:59058 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S272236AbTHRSyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:54:03 -0400
Message-ID: <3F4120DD.3030108@softhome.net>
Date: Mon, 18 Aug 2003 20:54:21 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
References: <lRjc.6o4.3@gated-at.bofh.it> <lRjg.6o4.15@gated-at.bofh.it> <lWLS.39x.5@gated-at.bofh.it> <lWLZ.39x.29@gated-at.bofh.it>
In-Reply-To: <lWLZ.39x.29@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>>hpa IIRC suggested to create a separate directory:
>>include/abi
>>and then all relevant parts of the kernel should publish their public
>>interface in the abi directory. Would that be usefull?
> 
> 
> I support include/abi, or some other directory that segregates
> user<->kernel shared headers away from kernel-private headers.
> 
> I don't see how that would be auto-generated, though.  Only created
> through lots of hard work :)
> 

    There is no need to be a prophet to predict linux/abi being 99% 
symlinks right into include/{asm,linux}.

    So it is can turn out to be the same ;-)
    It just adds job for mantainers.
    (To keep symlinks in correct order ;-)))))

    But generally idea is good: keep interface separately from 
implementation.

