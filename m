Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKAJbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKAJbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVKAJbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:31:10 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:6551 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750719AbVKAJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:31:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:Date:From:To:Subject:Message-Id:Reply-To:X-Mailer:Mime-Version:Content-Type:Content-Transfer-Encoding;
  b=5PpG3RCVBqLE5e7orlmT1mU5vqN86vI2v0UiKCzunWAlCzc/UVd+V6ApVT+Hp9L7Wwu8PcGY/+WideUzFbpjropIJLmuk3vofvwtJdomXPXb04jmXCkfAciOU9bHNia/N6RXeDCJnMvEYwI1QgX+QyEB6ePe7fnHfKJGJEoG9l0=  ;
Date: Tue, 1 Nov 2005 09:31:18 +0000
From: Geoff <capsthorne@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14 shutdown crash on smp (Badness in send_IPI_mask_bitmask)
Message-Id: <20051101093118.503be897.capsthorne@yahoo.co.uk>
Reply-To: capsthorne@yahoo.co.uk
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just moved from 2.6.10 to 2.6.14 (both self-compiled from
kernel.org sources)

Machine is smp (Asus VP6 mobo 2 x 1ghz PIII)

In my .config :
CONFIG_PM is not set
CONFIG_ACPI is not set

ACPI is switched off in the bios

In previous kernels I had crashes on  shutdown until I put
append="acpi=off"

On "shudtdown -h now" (never on "shutdown -r now") I am
crashing with :

Badness in send_IPI_mask_bitmask at
arch/i386/kernel/smp.c:167

Seems to be the same as problem reported on 10th September
by Frank van Maarseve for 2.6.14 :

2.6.13: Badness in send_IPI_mask_bitmask at arch/i386 

Andrew Morton followed up, but I am not sure what the
outcome was.

I will happily supply any further information do tests.

I am not subscribed to the list .. please cc me with any
replies.

Geoff

		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
