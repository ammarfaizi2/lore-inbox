Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbTEFOrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTEFOrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:47:36 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:44410 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263770AbTEFOre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:47:34 -0400
To: "Kurt Wall" <kwall@kurtwerks.com>
Date: Tue, 06 May 2003 10:58:06 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <HBEDLKMGIINBCDAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Disk Write
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I would like to write my data to a disk, without using any file system. I write directly to a raw disk and read it with my own function. Is this possible? Can I request a driver to write my data directly to the disk, and then use it to read the data also?

Sumit
--

On Mon, 5 May 2003 23:54:50   
 Kurt Wall wrote:
>An unnamed Administration source, Sumit Narayan, wrote:
>% Hi,
>% 
>% Actually, what I meant with this was, suppose I have a file name, how do I get the inode for that? And also suppose I have the inode number, how do I get the complete object of that inode for use and manipulation?
>
>If you have a filename, stat(2); see also lstat(2) and fstat(2).
>
>Kurt
>-- 
>Error in operator: add beer
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
