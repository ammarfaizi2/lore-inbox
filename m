Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUD1Ek5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUD1Ek5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 00:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUD1Ek5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 00:40:57 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:7609 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264641AbUD1Ekz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 00:40:55 -0400
Date: Wed, 28 Apr 2004 14:30:34 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Reply-To: ncunningham@linuxmail.org
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <20040428042742.GA1177@middle.of.nowhere>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 28 Apr 2004 06:27:42 +0200, Jurriaan <thunder7@xs4all.nl> wrote:
> From: Nigel Cunningham <ncunningham@linuxmail.org>
> Date: Wed, Apr 28, 2004 at 02:00:35PM +1000
>> Hi all.
>>
>> I'm probably going to regret this, but seeing the current discussion on
>> binary modules makes me wonder:
>>
>> What does tainting actually mean?
>>
> It means you can never be sure the bug is _not_ in some binary module.
> It may be unprobable, you may be able to find a bug in the kernel, but
> you're never _sure_.

Is that true? We can see where the oops occurs. If it's in the module,  
nothing more needs to be said. If it's in the kernel itself, we can check  
our source. We could check all the calls the module makes to open source  
code and validate that the parameters are correct. We should be able to  
say with authority 'the module is doing the wrong thing'. We might not be  
able to say exactly what, but we could determine that it is the module.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
