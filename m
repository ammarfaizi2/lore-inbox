Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWJWFlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWJWFlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWJWFlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:41:20 -0400
Received: from web32415.mail.mud.yahoo.com ([68.142.207.208]:29873 "HELO
	web32415.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751216AbWJWFlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:41:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UbmubyVVA/SaT58Xtsc0w3diwn5g6ulOUC0c1iVB/hWlUbguZi0XdH0GmS230gQyv4zvGZJkuwTkx0QLfNycjxLpSbplmHOP6aJnqF6Eg3mtBD5N/gUFRAySZuvaWu/FucweF6dgRnh1zBbpasFIoDU53rbbZH+eGfhMXsIhd60=  ;
Message-ID: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
Date: Sun, 22 Oct 2006 22:41:19 -0700 (PDT)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: incorrect taint of ndiswrapper
To: linux-kernel@vger.kernel.org
Cc: pgiri@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the kernel module loader taints ndiswrapper module as
proprietary, but it is not - it is fully GPL: see
http://directory.fsf.org/sysadmin/hookup/ndiswrapper.html

Note that when a driver is loaded, ndiswrapper does taint the kernel (to be
more accurate, it should check if the driver being loaded is GPL or not, but
that is not done).

Thanks,
Giri

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
