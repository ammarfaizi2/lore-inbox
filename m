Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVICKzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVICKzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 06:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVICKzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 06:55:44 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:38928 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750819AbVICKzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 06:55:43 -0400
Message-ID: <43198125.5010303@superbug.demon.co.uk>
Date: Sat, 03 Sep 2005 11:55:33 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: iSteve <isteve@rulez.cz>, linux-kernel@vger.kernel.org
Subject: Re: SysFS, module names and .name
References: <43176488.2080608@rulez.cz> <20050902155338.GA13648@kroah.com> <4318CF95.5040801@rulez.cz> <20050903053111.GB23711@kroah.com>
In-Reply-To: <20050903053111.GB23711@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Sep 03, 2005 at 12:17:57AM +0200, iSteve wrote:
> 
>>Yes, I am rather interested -- could you please provide details about 
>>this method?
> 
> 
> For PCI drivers, just add the line:
> 	.owner = THIS_MODULE,
> 
> to their struct pci_driver definition and you will get the symlink
> created for you.
> 
> USB drivers already do this.
> 
> Hope this helps,
> 
> greg k-h
> -

I will add this to the alsa driver snd-emu10k1 and snd-ca0106.

James

