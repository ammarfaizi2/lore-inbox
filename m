Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265016AbSJPOnl>; Wed, 16 Oct 2002 10:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265017AbSJPOnk>; Wed, 16 Oct 2002 10:43:40 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:63374 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265016AbSJPOni> convert rfc822-to-8bit;
	Wed, 16 Oct 2002 10:43:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [Q] e1000 hardware checksumming support?
Date: Wed, 16 Oct 2002 16:54:05 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161654.05783.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

Can Linux 2.4 use the hardware checksumming in the e1000 adapter? I mean .. my 
server is using most of it's time to csum_partial_copy_generic (and that's 
the checksum? or am I wrong?)

[root@vs1 /]# readprofile | sort -rn +2 | head -30
124855 default_idle                             1950.8594
 33335 handle_IRQ_event                         231.4931
 47663 csum_partial_copy_generic                205.4440
 13144 e1000_intr                               136.9167
  6526 fget                                     101.9688
  6474 system_call                              101.1562
  4620 sock_poll                                 96.2500
 10125 skb_release_data                          90.4018

thanks

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

