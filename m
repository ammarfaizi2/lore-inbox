Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTK1I1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 03:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTK1I1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 03:27:24 -0500
Received: from ztxmail02.ztx.compaq.com ([161.114.1.206]:8465 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262070AbTK1I1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 03:27:23 -0500
Message-ID: <3FC707B6.1070704@mailandnews.com>
Date: Fri, 28 Nov 2003 14:00:46 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange behavior observed w.r.t 'su' command
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, i am not sure if this is a kernel problem or an 'su' related issue, 
but this is what  i have observed. Tried on 2.4.20-8 ( RH 9.0 kernel ) 
and latest 2.6.0-test11.

- log in as any normal user. ( on Console.).
- su - root
- from root prompt, run 'ps' and check the pid of 'su'.
- kill -9 <pid of su>
After the kill command, strangely my keyboard switches to unbuffered 
mode ( a key press is processed immediately ). Also, i alternate between 
the root prompt and the normal user prompt.
Every key press switches from root prompt to normal user prompt and vice 
versa. Typing 'whoami' at the respective prompts displays 'normal user' 
and 'root' for the respective prompts.

What could be wrong ? Or am i doing something which i shouldnt be doing ?

/Raj


