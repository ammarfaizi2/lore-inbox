Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTKNRIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTKNRGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:06:09 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8638 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262784AbTKNRFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:05:24 -0500
Message-ID: <3FB50B4D.1000300@nortelnetworks.com>
Date: Fri, 14 Nov 2003 12:05:17 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why no Kconfig in "kernel" subdir?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was adding a new general syscall the other day, and it struck me as 
odd that there is no Kconfig in the "kernel" subdirectory.

A quick search shows 36 separate config options being used in that 
subdirectory (stuff like PREEMPT, SMP, FUTEX, HOTPLUG, SYSCTL, etc). 
Why is there no Kconfig for it?  As it stands, all of these have to be 
copied and pasted in every single arch.  This seems odd.

Would people be open to a series of patches that create a new Kconfig 
and start moving generic stuff to it?  Or are these things really 
arch-specific enough to warrent massive duplication?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

