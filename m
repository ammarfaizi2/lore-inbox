Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbULPXaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbULPXaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbULPXaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:30:16 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:42719 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262070AbULPX37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:29:59 -0500
Message-ID: <41C21A74.8090400@rnl.ist.utl.pt>
Date: Thu, 16 Dec 2004 23:29:56 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
In-Reply-To: <20041216190835.GE5654@kroah.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Dec 16, 2004 at 11:00:02AM -0800, Pete Zaitcev wrote:
> 
>>Hi Greg,
>>
>>what is the canonic place to mount debugfs: /debug, /debugfs, or anything
>>else? The reason I'm asking is that USBMon has to find it somewhere and
>>I'd really hate to see it varying from distro to distro.
> 
> 
> Hm, in my testing I've been putting it in /dbg, but I don't like vowels :)
> 
> Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?

well, since there is already a /sys, /proc... /debug wouldn't be that bad. 
perhaps the /.debug is better to keep it simple and away from people's eyes.

regards,
pedro venda.

-- 

Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
