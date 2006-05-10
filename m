Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWEJLkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWEJLkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWEJLkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:40:31 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:17859 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S964928AbWEJLka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:40:30 -0400
Message-ID: <4461D16A.3000301@keyaccess.nl>
Date: Wed, 10 May 2006 13:41:30 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc3 -- SMP alternatives: switching to UP code
References: <4461341B.7050602@keyaccess.nl> <4461B24A.7050805@suse.de>
In-Reply-To: <4461B24A.7050805@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann wrote:

> Rene Herman wrote:

>> Should I be seeing this "SMP alternatives" thing on a !CONFIG_SMP
>> kernel? It does say 0k, but something is apparently being done at
>> runtime still. Why?
> 
> The UP kernel has empty alternatives tables (as you've noticed), thus
> the code doesn't do anything.  Nevertheless it probably makes sense to
> add a few #ifdef CONFIG_SMP lines to avoid confusing people and safe a
> few bytes ...

Okay, thanks. Yes, I agree such would make sense.

Rene.


