Return-Path: <linux-kernel-owner+w=401wt.eu-S932737AbWLNN70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWLNN70 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWLNN70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:59:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:35419 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737AbWLNN7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:59:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QYGHVM/2uwVbE9QuVsK7YphN6l/9n9Sg1/UT7K7S/OfLQhiQ9NMB/z4EvV0s6vJpuL/UgyrgNyfA/b4EggjbCfLDKvq/Ad/zFyhy6SNyW9kg2QlG4ttWScJI2nzCIXW40wpSRQfeeF2FaOdRWcF47Cz8z5FK/6rEY6SUdeZu6ZU=
Message-ID: <5a4c581d0612140559l6ecb2343o26dd31ace0cd7dd5@mail.gmail.com>
Date: Thu, 14 Dec 2006 14:59:23 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc1
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok, the two-week merge period is over, and -rc1 is out there.

Still need this libata-sff.c patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw

 to have my root device detected, ata_piix probe would otherwise
 fail as described in this thread:

http://www.ussg.iu.edu/hypermail/linux/kernel/0612.0/0690.html

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
