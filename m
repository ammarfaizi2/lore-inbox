Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUDQSvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUDQSvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:51:35 -0400
Received: from opersys.com ([64.40.108.71]:15376 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262905AbUDQSve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:51:34 -0400
Message-ID: <40817E14.7040500@opersys.com>
Date: Sat, 17 Apr 2004 14:57:24 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: MNH <tuxracer@gawab.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt handler
References: <1082023366.3953.6.camel@localhost.localdomain>
In-Reply-To: <1082023366.3953.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


MNH wrote:
> If a process is executing a system call, and an interrupt is invoked,
> the process blocks. Now since interrupt handlers cannot block, the time
> for which the IH runs is taken out of the process's time-slice ( Is this
> right ?).
> 
> What if the IH takes up all of the process's time-slice, does the
> process gets knocked off the current list and thrown into the expired
> list or is there something more to it?

This is the kind of thing LTT will allow you to see:
http://www.opersys.com/LTT/

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

