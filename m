Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268226AbUHKVNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268226AbUHKVNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUHKVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:13:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:16802 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268226AbUHKVNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:13:09 -0400
X-Authenticated: #494916
Message-ID: <411AC46D.6080307@gmx.de>
Date: Thu, 12 Aug 2004 03:14:21 +0200
From: Peter Schaefer <peter.schaefer@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: [VIA-RHINE] Timeouts on EP-HDA3+ Motherboard
References: <41181BF7.6060002@gmx.de> <20040809215424.GA12237@k3.hellgate.ch> <4118A534.8050903@gmx.de> <20040810070651.GB11224@k3.hellgate.ch>
In-Reply-To: <20040810070651.GB11224@k3.hellgate.ch>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2004 09:06, Roger Luethi wrote:
> On Tue, 10 Aug 2004 12:36:36 +0200, Peter Schaefer wrote:
> 
>>The box is currently running 2.6.7 vanilla. I've installed
>>it starting with 2.6.1 (as 2.4.x doesn't support the hardware
>>proberly) and the problem has existed ever since.
> 
> 
> Try 2.6.8-rc3 or later. Let me know if it works (if it doesn't, I'm
> not sure I want to know :-/).

As this is a production machine i haven't had the balls to move to
2.6.8-rc3. Instead, i took only the via-rhine.c from 2.6.8-rc4-mm1
applied your last patch to it and recompiled the module.

What should i say: It works! I wasn't able to trigger the error with
my standard test (copying a 680MB ISO image from/to Samba shares in
parallel). An this even with "large readwrite" enabled in smb.conf.

So, i consider this gone - for now :)

          (But perhaps you should update the drivers version number)

Thank you very much!

  Best regards,

    Peter
