Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTE0ObO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTE0ObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:31:14 -0400
Received: from pop.gmx.net ([213.165.64.20]:2494 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263632AbTE0ObN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:31:13 -0400
Message-ID: <3ED379C3.10404@gmx.net>
Date: Tue, 27 May 2003 16:44:19 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephen Torri <storri@sbcglobal.net>
CC: vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding reason for "Attempted to kill init"
References: <1053993371.17560.16.camel@base>	 <200305271219.h4RCJSu10402@Port.imtp.ilyichevsk.odessa.ua> <1054046931.26795.9.camel@base>
In-Reply-To: <1054046931.26795.9.camel@base>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Torri wrote:
> On Tue, 2003-05-27 at 07:25, Denis Vlasenko wrote:
> 
>>On 27 May 2003 02:56, Stephen Torri wrote:
>>
>>>I can see from kernel/exit.c where the message "Attempted to kill
>>>init" comes from in the kernel. That is good. What would be helpful
>>>is to deteremine where in the code the function do_exit() is called.
>>>Is there a way to do that? I am trying to hunt down a boot failure
>>>for a kernel on a Gentoo LiveCD. I am in communication with the
>>>developers of the Gentoo Alpha list about this problem?
>>
>>Your /sbin/init exits
> 
> So because this binary file exists the kernel will not boot?

exist != exit

If init terminates, your system is borked anyway.


Regards,
Carl-Daniel

