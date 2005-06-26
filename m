Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFZQf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFZQf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFZQf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:35:57 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:8275 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261398AbVFZQej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:34:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Fqtfcb4xAXC8XCrwnYXA3ncWRud0lyQDmZGo6rgQ2gk4mK1uUawUlgKK/0tnulUyZSGmtldenxxwYRPUkMp9Hcw0KLEJrfqntR/I1AfH6f/Ng+v7tAaj0+LT8xe1qx+pThQJg9fsAS2Xd+EaONEAHoaXQNR6aowiHbIc+EOpK6M=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stelian Pop <stelian@popies.net>
Subject: Re: rmmod ohci1394 hangs in klist_remove
Date: Sun, 26 Jun 2005 20:40:45 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <1119537610.5848.3.camel@localhost.localdomain>
In-Reply-To: <1119537610.5848.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262040.45622.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 June 2005 18:40, Stelian Pop wrote:
> Removing the ohci1394 module no longer works, sysrq+t shows:
> 
> rmmod         D 0FF7F724     0  6044   6038                     (NOTLB)
> Call trace:
>  [c00073ec] __switch_to+0x48/0x70
>  [c02954c8] schedule+0x348/0x6f8
>  [c02958f0] wait_for_completion+0x78/0xe4
>  [c0294c1c] klist_remove+0x24/0x38

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4802

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.

P.S.: Correct version number if my guess about it was wrong.
