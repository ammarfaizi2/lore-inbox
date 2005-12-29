Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVL2Q3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVL2Q3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVL2Q3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:29:38 -0500
Received: from web34106.mail.mud.yahoo.com ([66.163.178.104]:11691 "HELO
	web34106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750799AbVL2Q3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:29:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MOuyl0bTeYZogAKZX+hnQHvj9tXn2Pn1FawdlIXtIxTxdahyPQtjWH9gkU5lKkDRQkCQqCpGxVtkLRcsATCE2f9jJVgZVrj6dh4yi+fzjGFLu7VGfuO0iJVGPUmh939Yfjxn61NQ6fseL7ZK5cLuSkPllJwB5gSTlpbRpsUq6i8=  ;
Message-ID: <20051229162935.67301.qmail@web34106.mail.mud.yahoo.com>
Date: Thu, 29 Dec 2005 08:29:35 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: RAID controller safety
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I am trying to determine which drivers and what hardware can be used to give reliable fsync
behavior.  I see many drivers with FIXME or TODO comments which make me nervous.
  I see the sd driver supports the direct SYNCHRONIZE_CACHE, but I'me having a hard time tracing
through how this translates to raid controllers and their drivers.
  Specificly, I am looking at the Adaptec RAID controllers and their i2o drivers.  I am told the
kernel's i2o driver lacks a strong guarantee on fsync, and so far am unable to determine if the
dpt_i2o driver also falls short in this reguard.

  I don't mean to start a 'drives lie - disable all caching, buy FC drives' flame war.  I know
drives can lie, but I'd like to know if the drivers are lying too.

thanks,
-Kenny



	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
