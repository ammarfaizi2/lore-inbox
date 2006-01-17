Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWAQUyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWAQUyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWAQUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:54:43 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:29190 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S964825AbWAQUyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:54:43 -0500
Message-ID: <43CD599B.8050002@superbug.demon.co.uk>
Date: Tue, 17 Jan 2006 20:54:51 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Willy Tarreau <willy@w.ods.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
References: <43CA883B.2020504@superbug.demon.co.uk> <20060115192711.GO7142@w.ods.org> <43CCE5C8.7030605@superbug.demon.co.uk> <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>My point is that there is no way to tell what kills me. No messages in
>>syslog...nothing. Surely the OOM killer would send a message to ksyslog, or at
>>least dmesg?
>>
> 
> Yes, OOM usually does printk(). So it depends on how you have syslog set 
> up (and the console loglevel - which is reponsible for bringing it right 
> to console).
> 
> 
> Jan Engelhardt

So, I can conclude that as I am not seeing any OOM messages in dmesg, 
that the OOM is not responsible for my kills. Even without syslog set 
up, I should see the OOM in dmesg shouldn't I?

So, I have a mystery reason why X getting killed.

Can anyone else suggest any other possible causes for unexpected X 
getting killed?

James

