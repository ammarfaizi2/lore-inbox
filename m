Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVAZIOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVAZIOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVAZIOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:14:47 -0500
Received: from web52201.mail.yahoo.com ([206.190.39.83]:26978 "HELO
	web52201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262381AbVAZIOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:14:32 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=dApWQlesNXZi7yTBk0e10eL4KO0SPgZFtRE1t5VelqUwhd8qpte8nkX062WsG6bRWoSnxVRt6LMIJCnSjm+Q/iZhlrbv4BekuWVsT+dn2v4phhtru3gLwZk/NBgIRVC6UoMiDajnwFrge+PkoWAKoL+ZHLfFGVCWoesp67gaK2I=  ;
Message-ID: <20050126081431.39354.qmail@web52201.mail.yahoo.com>
Date: Wed, 26 Jan 2005 00:14:30 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Some kernel source questions...
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
       I have some questions...
1)When data is copied to ICMP/UDP packets? 
when i trace kernel code in 2.4.26 kernel version is
that in case of ICMP and UDP packets the packet gets
its space allocated in ip_build_xmit function and then
ip header is built.
2) What getfrag does? Does it copies actual data in
packet?
3)Also can anybody explain me function 
int ip_build_xmit(struct sock *sk,int getfrag (const
void *,char *,unsigned int, unsigned int),const void
*frag,
		  unsigned length,
		  struct ipcm_cookie *ipc,
		  struct rtable *rt,
		  int flags)
and its parameter usage???

regards,
linux_lover


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
