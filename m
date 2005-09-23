Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVIWFmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVIWFmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVIWFmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:42:49 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:60338 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S1751064AbVIWFmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:42:49 -0400
Message-ID: <4333944D.2060503@cdac.in>
Date: Fri, 23 Sep 2005 11:06:13 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT for block device
References: <4332697C.7070409@cdac.in> <20050922084036.GI27375@ca-server1.us.oracle.com> <43329590.3050006@cdac.in> <20050922152028.GJ27375@ca-server1.us.oracle.com>
In-Reply-To: <20050922152028.GJ27375@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Thu, Sep 22, 2005 at 04:59:20PM +0530, Karthik Sarangan wrote:
> 
>>I tried your tip and the read works beautifully but the write returns -1 
>>and errno = EBADF!
> 
> 
> 	Did you open with O_RDWR?
> 
> Joel
> 

Alright I didn't, though using O_DIRECT | O_RDWR the second time solved 
it :-) I finally got 69MBps read and 49 MBps writes on my SCSI disk.

Thanks for helping me out.
