Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUKWNFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUKWNFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKWND7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:03:59 -0500
Received: from web41403.mail.yahoo.com ([66.218.93.69]:14759 "HELO
	web41403.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261246AbUKWNCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:02:50 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=OONiszunuCvWn/n0rZ+XJSx4bz2VovrhMp5NSkljR5plpbzWgGehJ+HWbl2CD+iCXtYHDAu+rjxEbGSSSJZ25aZh5LKWzOXnOc4hacKpglvrnt2SkJvzpzcNJ42Qk8mlux7V3YRg6rJl4mlhRXhQwRAcT7KDOvhU0LNiyBTbphw=  ;
Message-ID: <20041123130245.82710.qmail@web41403.mail.yahoo.com>
Date: Tue, 23 Nov 2004 05:02:45 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: using skbuff functions in kernel module
To: netfilter devel <netfilter-devel@lists.samba.org>
Cc: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I want to add new header between IP and ETHERNET
layer. I want to ask can it be done using netfilter
hooks? 

Can skb functions (skb_reserve,skb_push,skb_pull)be
allowed to use in kernel module so that i can add at
NF_IP_LOCAL_OUT and pull my own header at
NF_IP_LOCAL_IN?
I want to add header using kernel modules.

regards,
cranium


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

