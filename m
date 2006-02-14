Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWBNTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWBNTNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWBNTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:13:41 -0500
Received: from web50302.mail.yahoo.com ([206.190.38.56]:24743 "HELO
	web50302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1422660AbWBNTNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:13:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ELJnxu3LZQjOBNq/E7KK7PmrOEJYfrq8HCyQcXb9GWxn4LTMlt33fuIUuWMzKpTM2tfrQg8Zkev0fI5tjaCGuxesOa2CUisxRSIgX097KyKKoXRVAAnkHEKHuLK/etxgNFrGvxLZRfRTbBpJsdp2AP07g8EoC07NLGsqIlZgRRE=  ;
Message-ID: <20060214191337.25546.qmail@web50302.mail.yahoo.com>
Date: Tue, 14 Feb 2006 11:13:37 -0800 (PST)
From: omkar lagu <omkarlagu@yahoo.com>
Subject: inet_sendpage..
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

struct page *page;
page=alloc_pages(GFP_KERNEL,0);
oldms = get_fs(); set_fs(KERNEL_DS);
suc=sockt->ops->sendpage(sockt,page,0,4096,0);
set_fs(oldms);

this stuff doesn`t work .. i am not understanding why
..
and can anyone explain more abt the parameters in
sendpage primitive...
and i have done a printk(suc) its a negative value i
don`t think that sendpage call was succesfull cause i
have a opinion that it should return 0 on success;

thanks in advance 
plz CC to omkarlagu@yahoo.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
