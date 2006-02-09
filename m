Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWBITZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWBITZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWBITZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:25:12 -0500
Received: from web50307.mail.yahoo.com ([206.190.38.61]:37977 "HELO
	web50307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750727AbWBITZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:25:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PQNZbVw4IUuZttFJWRsfC9sMWcN95Vn8bGTC1297Bxyuow2NAsytVDIhHkJ5R+wWi4R7Ac0UfWHQOp8VrEq5WvPFVK4BgrLuSdlX+TdJosnUcEIqMIu3BhDsvUdM9TWEzU07TGmc/J9w0jl4CVpgHIwrkcqIviN8zC/DXTS/0vE=  ;
Message-ID: <20060209192510.32377.qmail@web50307.mail.yahoo.com>
Date: Thu, 9 Feb 2006 11:25:09 -0800 (PST)
From: omkar lagu <omkarlagu@yahoo.com>
Subject: Fwd: How to call a function in a module from the kernel code !!! (Linux kernel)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 hello sir,
 
 PROBLEM::How to call a function in a module from the
 kernel code ??
 
 what we did ? :: 
 we wanted to call a function in our module ll from
 shm.c file (which is in the kernel)
 
 so we declared function pointer in shm.c
 :: unsigned long long (*ptr1)(int)
 
 we declared it as extern in shm.h
 :: extern unsigned long long (*ptr1)(int)
 
 then we declared also in our module  (ll)
 :: extern unsigned long long (*ptr1)(int)
 
 we initialized it to ptr1 = commun; in init module
 of ll.c
 where commun is we wanted to call from the kernel
   
 but it gave an error as undefined refernce to ptr1
 when we inserted our module..
 
 can you help on this thing or can you give us a
 example 
 regarding how it is done ??
 
 waiting for a reply 
 plz cc to omkarlagu@yahoo.com


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
