Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUHHFWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUHHFWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUHHFWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:22:43 -0400
Received: from main.gmane.org ([80.91.224.249]:59361 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265144AbUHHFWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:22:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Linux Kernel bug report (includes fix)
Date: Sun, 08 Aug 2004 11:22:18 +0600
Message-ID: <cf4dab$jbf$1@sea.gmane.org>
References: <schilling@fokus.fraunhofer.de> <200408080118.i781Isku007461@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 51-173.dial.utk.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <200408080118.i781Isku007461@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Joerg Schilling <schilling@fokus.fraunhofer.de> said:
> 
>>-	Linux Kernel include files (starting with Linux-2.5) are buggy and 
>>	prevent compilation.
> 
> 
> They do not, the kernel compiles just fine. They are _not_ to be used for
> random userspace programs.

You are supposed to either bring the needed "sanitized" kernel headers 
with your program, or have those provided by the linux-libc-headers 
(http://ep09.pld-linux.org/~mmazur/linux-libc-headers/) in /usr/include. 
Adding /usr/src/linux/include to the gcc search path is a bug in 
userspace programs.

-- 
Alexander E. Patrakov

