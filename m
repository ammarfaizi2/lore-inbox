Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWC1Pew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWC1Pew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC1Pew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:34:52 -0500
Received: from web8409.mail.in.yahoo.com ([202.43.219.157]:55953 "HELO
	web8409.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751078AbWC1Pew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HYsJu/shUkYhjoXPUNNDgjzJpzpaAQW5Spk230KwofGVxMSZB17Q0a7o8h+QPccnCYUPT9GZsWxdNYYNFNKOaA3y37Gb2QB/bglN5wnklVdGUmHYzPTQT51fS58Q7ArHey26FASUj3Pb9LIa5sKs1VZ43NR3wgDDjdqla2PxyK0=  ;
Message-ID: <20060328153449.3321.qmail@web8409.mail.in.yahoo.com>
Date: Tue, 28 Mar 2006 16:34:49 +0100 (BST)
From: yenganti pradeep <pradeepls143@yahoo.co.in>
Subject: procfs question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've created a new entry under /proc, to make tests.

I've defined an static int var=0;

Then I link my proc entry read function to a function
that only performs this:

int length;
length=sprintf(page,"Value %d",var++);

return length;

But when I cat/vi the file continuosly I get:

Value 0
Value 3
Value 6

etc...

Why is this three numbers increment? 

Thanks
Pradeep





		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
