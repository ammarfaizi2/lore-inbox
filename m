Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUIDQ7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUIDQ7U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUIDQ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 12:59:20 -0400
Received: from [202.76.92.172] ([202.76.92.172]:1038 "EHLO main.coppice.org")
	by vger.kernel.org with ESMTP id S264377AbUIDQ7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 12:59:16 -0400
Message-ID: <4139F3FA.1070107@coppice.org>
Date: Sun, 05 Sep 2004 00:57:30 +0800
From: Steve Underwood <steveu@coppice.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: persistent ptys
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems BSD style ptys are on the way out, and most systems will soon 
have just Unix98 style ptys. This makes me want to move something to 
Unix98 ptys, but I'm not sure of the appropriate way. The issue is that 
things like HylaFAX expect to work with well known, persistent, names 
for modem ports. A 100% soft modem in user space can easily provide that 
with BSD ptys. With Unix98 ptys it is not so obvious what to do. Most 
commercial soft modems don't have this issue, as they are part kernel 
space/part user space designs. Obviously creating a link to a 
dynamically generated pty with a well known name, and various other 
things could be done. However, I assume other people have had to do 
similar persistent pty things, and there is a well defined common 
practice for it. Can anyone tell me what it is? :-\

Regards,
Steve

