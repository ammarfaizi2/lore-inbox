Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTBKCna>; Mon, 10 Feb 2003 21:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTBKCna>; Mon, 10 Feb 2003 21:43:30 -0500
Received: from sccimhc02.insightbb.com ([63.240.76.164]:54227 "EHLO
	sccimhc02.insightbb.com") by vger.kernel.org with ESMTP
	id <S265854AbTBKCn3>; Mon, 10 Feb 2003 21:43:29 -0500
Message-ID: <3E486596.2090800@ntr.net>
Date: Mon, 10 Feb 2003 21:53:10 -0500
From: "Marco C. Mason" <mason@ntr.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, raid@a2000.nu
Subject: fsck out of memory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan--

I don't know if anyone mentioned it or not, but the block addresses in your
error messages appear suspiciously close to 2^29.  I'm suspecting an 
internal
overflow in a calculation somewhere...

--marco


