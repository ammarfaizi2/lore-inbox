Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbSKSWCt>; Tue, 19 Nov 2002 17:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbSKSWCt>; Tue, 19 Nov 2002 17:02:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14090 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267512AbSKSWCs>;
	Tue, 19 Nov 2002 17:02:48 -0500
Message-ID: <3DDAB6AD.4050400@pobox.com>
Date: Tue, 19 Nov 2002 17:09:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: spinlocks, the GPL, and binary-only modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blah.

So, since spinlocks and semaphores are (a) inline and #included into 
your code, and (b) required for just about sane interoperation with Linux...

does this mean that all binary-only modules that #include kernel code 
such as spinlocks are violating the GPL?  IOW just about every binary 
module out there, I would think...

I'm sure this would make extremeists happy, but I personally don't mind 
binary-only modules as long as the binary-only code [ignoring the 
#included kernel code] cannot be considered a derived work.

But who knows if #include'd code constitutes a derived work :(

	Jeff



