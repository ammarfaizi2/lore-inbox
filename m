Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTDVStf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTDVStf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:49:35 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:41737 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263354AbTDVStf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:49:35 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: <aglait@nixe.com>
Subject: Re: Kernel & libc
Date: Tue, 22 Apr 2003 21:01:28 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.10.10304221529270.15950-100000@soraya.nixe.com>
In-Reply-To: <Pine.LNX.4.10.10304221529270.15950-100000@soraya.nixe.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304222101.28725.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 April 2003 20:32, aglait@nixe.com wrote:
> Can you help me ?? 
maybe :)

> I want to know if there is a requirement of libc,
> glibc for kernel 2.4.20 ...
Kernel doesn't use libc (uses -nostdinc).
You can't use any library from user-space in kernel.

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

