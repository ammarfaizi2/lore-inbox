Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTJQSv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJQSv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:51:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38016 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263588AbTJQSvz
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 17 Oct 2003 14:51:55 -0400
Message-ID: <3F903A49.4090007@namesys.com>
Date: Fri, 17 Oct 2003 22:51:53 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: new reiser4 snapshot
References: <16272.3551.934067.370680@laputa.namesys.com>
In-Reply-To: <16272.3551.934067.370680@laputa.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This snapshot fixes two fatal bugs, and improves performance.  Nikita 
can still make it crash, sigh, and we have discovered some unnecessary 
seeks when replicating Mike Benoit's settings for bonnie++ that are due 
to block allocation bugs.  Sigh.  We are probably still at least 2 weeks 
away from code that we can seriously ask people to use.  The performance 
is good enough to be well worth using despite the allocation bugs, but 
we don't like to ask people to use code we know how to crash.

-- 
Hans


