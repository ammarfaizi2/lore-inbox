Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVCKUgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVCKUgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVCKUgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:36:17 -0500
Received: from mail.tmr.com ([216.238.38.203]:54020 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261315AbVCKUeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:34:12 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Can I get 200M contiguous physical memory?
Date: Fri, 11 Mar 2005 15:39:42 -0500
Organization: TMR Associates, Inc
Message-ID: <4232020E.5050402@tmr.com>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com> <d0p1ag$ngk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1110572547 20134 192.168.12.100 (11 Mar 2005 20:22:27 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel@vger.kernel.org
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <d0p1ag$ngk$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Holbe wrote:
> Jason Luo <abcd.bpmf@gmail.com> wrote:
> 
>>Now, I am writing a driver, which need 200M contiguous physical
>>memory? can do? how to do it?
> 
> 
> The ftape utils have a tool called swapout which tries to 'free'
> large chunks of memory which then can be allocated by the ftape
> module loaded subsequently.
> I don't know if this approach does also work with *such* large
> chunks like yours.

Wasn't there a problem with a process having mlocked memory in the wrong 
place and the application hanging? Or the kernel hanging? Or something. 
Can't remember.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
