Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTINEDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 00:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTINEDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 00:03:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6338 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262321AbTINEDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 00:03:38 -0400
Message-ID: <3F63E898.4010803@namesys.com>
Date: Sun, 14 Sep 2003 08:03:36 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: George <george@xorgate.com>
CC: linux-kernel@vger.kernel.org, Oleg Drokin <green@namesys.com>
Subject: Re: 2.6 kernel large file create problem
References: <000501c37a0c$e2ad24a0$3eac18ac@geosxp>
In-Reply-To: <000501c37a0c$e2ad24a0$3eac18ac@geosxp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George wrote:

>I have a 300G reiserfs 3.6 file system created above a RAID0 (HPT372
>controller) partition.  When I am using the 2.6.0-test5 kernel and create
>files larger that 4GB they are corrupted with lots of trash throughout the
>file.  When I use the same file system with the 2.4.22 kernel it works fine.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
this bug was just found and fixed, green has details.

-- 
Hans


