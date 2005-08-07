Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752757AbVHGVM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbVHGVM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbVHGVM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:12:27 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:44887 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S1752760AbVHGVM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:12:26 -0400
Message-ID: <42F6792D.4030608@home.se>
Date: Sun, 07 Aug 2005 23:12:13 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>	 <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain>
In-Reply-To: <1123249743.18332.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> I don't have the card, so I can't test it. But if this works (after
> removing the previous patch) then this is the better solution. 

I can confirm that this alone does not work for the simple 
unplug/re-plug cycle I described, it still locks up hard. Tried this 
alone on -rc6.

---
John Bäckstrand
