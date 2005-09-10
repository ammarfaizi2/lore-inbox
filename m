Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVIJB2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVIJB2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbVIJB2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:28:14 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3473 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030413AbVIJB2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:28:14 -0400
Message-ID: <43223696.5020902@pobox.com>
Date: Fri, 09 Sep 2005 21:27:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, gregkh@suse.de, davej@codemonkey.org.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org> <20050909225421.GA31433@suse.de> <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org> <20050909163634.21afe4ca.akpm@osdl.org> <Pine.LNX.4.58.0509091644050.30958@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509091644050.30958@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 9 Sep 2005, Andrew Morton wrote:
> 
>>If something like a PCI power management function fails then it will likely
>>cause suspend or resume to malfunction, and we have a lot of such problems.
> 
> 
> No, for several reasons.
> 
> First off, some of those functions can't fail in normal usage. Thus 
> telling people that they have to check the return code is insane.
> 
> Secondly, at least some of the suspend failures have historically been
> because drivers returned errors for no good reason. Adding yet another 
> broken reason to return error is not going to help.

Agreed.

	Jeff



