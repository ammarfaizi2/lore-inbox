Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUBRIrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 03:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUBRIrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 03:47:49 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:48620 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263632AbUBRIrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 03:47:47 -0500
Message-ID: <40332666.60703@t-online.de>
Date: Wed, 18 Feb 2004 09:46:30 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>, rusty@rustcorp.com.au
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <402A887D.7030408@t-online.de> <402EDBA8.4070102@lovecn.org> <402F42DE.5090308@t-online.de> <20040217184132.541a5a76.rusty@rustcorp.com.au> <20040217202839.A16590@animx.eu.org>
In-Reply-To: <20040217202839.A16590@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Tzo-wqZcre7uZ-QWtuaCGuDsh27WRjmdPKaNM4llPLAevt7eHiwW0l
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Rusty Russell wrote:
> 
>>Most users don't want to remember that it's ip_conntrack but uhci-hcd.
> 
> 
> I'd like to chime in about this.
> 
> I'd prefer it be - all the way around (I know I can use either).  Since I
> can ask for module uhci_hcd or uhci-hcd and get uhci-hcd.ko loaded, I've
> been using -.  It's a bit easier to type since I don't have to hit shift for
> each _
> 

It is really not important here whether anybody prefers '_'
or '-'. IMHO everybody should be free to use both, even
within one symbol filename.

What I do not like is that /proc/modules lies about the
names of the loaded modules. I can understand that you
are not affected by this problem, because all you see is
module-init-tools, but others _are_ affected.


Regards

Harri
