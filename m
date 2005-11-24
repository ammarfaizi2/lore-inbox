Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVKXPJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVKXPJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVKXPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:09:31 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:38555 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751365AbVKXPJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:09:30 -0500
Message-ID: <4385D79E.5060107@rtr.ca>
Date: Thu, 24 Nov 2005 10:09:18 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
Cc: Jan Panoch <jan@panoch.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] PATA support for Intel ICH7 (intel 945G chipset) - 2.6.14.2
References: <4383DC5E.3050601@panoch.net> <438453C9.4050200@gentoo.org>
In-Reply-To: <438453C9.4050200@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
>
> Documentation/SubmittingPatches). I don't think it will be accepted 
> because this hardware is already supported by the ata_piix libata driver.

That is not a valid reason to reject -- libata is still considered
very experimental for ATAPI devices, which are not enabled by default.

Jeff has said that he prefers (at present) for people with ATAPI drives
to use the IDE layer rather than libata, where possible.

That will change soon, but it's still the case for now.

Cheers
