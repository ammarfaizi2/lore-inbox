Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSFEWcJ>; Wed, 5 Jun 2002 18:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSFEWcJ>; Wed, 5 Jun 2002 18:32:09 -0400
Received: from mail1.mail.iol.ie ([194.125.2.192]:17043 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP
	id <S316523AbSFEWcI>; Wed, 5 Jun 2002 18:32:08 -0400
Message-ID: <3CFE9181.7090603@antefacto.com>
Date: Wed, 05 Jun 2002 23:32:33 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <3CFDEA79.2980BF8D@zip.com.au> <3CFE5A50.9010002@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I've also thought in the past of having a "machine_policy" global 
> variable, which could indicate to random userspace and kernel code a 
> "laptop mode" or "file server mode" or "database server mode" etc.

I'm not too sure this level of abstraction is needed by userspace.
It would be enough if the appropriate things were all controlable
in /proc/sys/ etc. and then you just have:
/etc/sysctl.{laptop,server,desktop}.conf
It would be better to have it explicit in userspace as you're
always going to need to tweak things IMHO.

Padraig.

