Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTJBGgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 02:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTJBGgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 02:36:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13958 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263265AbTJBGgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 02:36:38 -0400
Message-ID: <3F7BC775.7080208@namesys.com>
Date: Thu, 02 Oct 2003 10:36:37 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
CC: linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
References: <E1A4oAm-0005p3-00@calista.inka.de>
In-Reply-To: <E1A4oAm-0005p3-00@calista.inka.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:

>In article <20030912044820.GG26618@matchmail.com> you wrote:
>  
>
>>And if you have no superblock how does it know where the journal is?
>>    
>>
>
>You can search it by magic number, asume a fixed start location or whatever.
>
>Greetings
>Bernd
>  
>
We are currently doing a review of what data should  be duplicated 
elsewhere.  Most of what is in the superblock is best simply recreated 
if lost, but we are still having discussions about some particular 
fields, and where to replicate them.  We expect to complete this review 
this week.

-- 
Hans


