Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVGPSfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVGPSfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVGPSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 14:35:20 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:10349 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261792AbVGPSfS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 14:35:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B2vrD1cS7D4Fms6WpfeWf0vBRi+Jt1ZD8SSFINAWkPZ+FOj9kmLc5gJ3ZpC98IACTZXJC6/dKA42Uv1+dJL7Zm3fQpAp6g4qiqh+bs0IfA2u64Pq57fdspRazSuM2k9cXiQVkHMMky+9xKcq8lH6QNHT5YBGW2B1McB2jM9CnjM=
Message-ID: <6bffcb0e05071611347cadc52b@mail.gmail.com>
Date: Sat, 16 Jul 2005 20:34:21 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz>
Subject: Re: init 0 stopped working
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050716000947.GA24094@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050716000947.GA24094@ribosome.natur.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/16/05, Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz> wrote:
> Hi,
>   I used to shutdown my P4 machine based on ASUS P4C800E-Deluxe
> with simple "init 0" command. That somehow broke between 2.6.12-rc6-git2
> and 2.6.13-rc1. The machines makes the sound like shutdown but it
> immediately turns the power on again. I used acpi and the kernel
> configs should be almost identical in all cases, as I just recopy
> previously used .config and run "make oldconfig".
> 
>   Any clues? I still happens even with 2.6.13-rc3-git2.
> Please Cc: me in replies.
> Martin


I have the same problem.
System: Debian 3.1
Hardware:
motherboard P4P800 (with bios 1019)

It may be problem around acpi in asus board. But 2.6.12.1 works good.

Regards,
Michal Piotrowski
