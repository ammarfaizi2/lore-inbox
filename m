Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWECHEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWECHEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWECHEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:04:41 -0400
Received: from web52613.mail.yahoo.com ([206.190.48.216]:53861 "HELO
	web52613.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965102AbWECHEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:04:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=b4hvWFxw5Ta4GGCdxPNrbFWsGhJ1ubbWNzhspPazb8tHf0S8U8L3xeT/93XjgkG8ynE/FJm/E0SPumYSRtKu5/YGRReuxmqaMNwb9mZEoXUEzNgjVBZJxArCKOV/fQnZmucVpVgUyHqHQQSF9gP3LLDw0Rb//Q5O9aZyf0ciWvQ=  ;
Message-ID: <20060503070440.53101.qmail@web52613.mail.yahoo.com>
Date: Wed, 3 May 2006 17:04:40 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.16.1 & D state processes
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1145515879.9712.11.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Mike Galbraith <efault@gmx.de> wrote:
> On Thu, 2006-04-20 at 08:45 +0200, Mike Galbraith
> wrote:
> 
> > Good idea.  What time source are you using?  I'd
> try plain old pit.
> 
> (Looking back, I see you're using pm timer.)

Actually, I narrowed it down to
"CONFIG_X86_UP_IOAPIC". When it isn't compiled in, all
is well.

(Yes it wasn't there in my minimal .config either. And
yes, my BIOS is the latest available for this IBM P-IV
NetVista desktop - BIOS as recent as Aug 2005, I'm
sure.)

Now I'll have to try myriad ioapic kernel boot
parameters :-( to see if there is a setting in which
it'll work nice.

Any clues?

Thanks


		
____________________________________________________ 
On Yahoo!7 
Dating: It's free to join and check out our great singles! 
http://www.yahoo7.com.au/personals
