Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbTCNJqR>; Fri, 14 Mar 2003 04:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCNJqR>; Fri, 14 Mar 2003 04:46:17 -0500
Received: from [196.3.115.158] ([196.3.115.158]:60077 "EHLO
	lastman.belessex.co.za") by vger.kernel.org with ESMTP
	id <S261466AbTCNJqQ>; Fri, 14 Mar 2003 04:46:16 -0500
Reply-To: <mirco.ellis@isoftpe.co.za>
From: "Mirco Ellis" <mirco.ellis@isoftpe.co.za>
To: <linux-kernel@vger.kernel.org>
Subject: smb_request kernel messages
Date: Fri, 14 Mar 2003 11:55:55 +0200
Message-ID: <003b01c2ea0f$e8a19db0$3697a8c0@MIRCO>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have done a simple mapping from my linux server 2.4.X to a NT4 box "
smbmount //server/share /root/dir -o username=myuser,password=mypass". I
have included the command in rc.local  so that the share will be remapped
after every reboot. Everything is working fine, but I am receiving the
following error on /var/log/messages and it also appears on the screan:

smb_request:result_104,setting invalid
smb_retry:successful,new pid=1635, generation=21

This happens once every hour on the hour. Any ideas??


