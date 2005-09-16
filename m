Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbVIPIM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbVIPIM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVIPIM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:12:27 -0400
Received: from web51002.mail.yahoo.com ([206.190.38.133]:12904 "HELO
	web51002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161126AbVIPIMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:12:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=O+ZCH+gGon+lzPEMFSQoZ9qRz63TdhTvS4wJsOgkGzsZQNhdMOMeMAEwstgsDN1eypZVX+UqovHGtDC2dZExSpD8R9Wjx/8KtAUGqreatvkZ3kBmAlq8M4bblNJc6sDojj4zS9rdw/cApos56cs5/CIg+wsoDIt7BR3WSWi0bcA=  ;
Message-ID: <20050916081221.48974.qmail@web51002.mail.yahoo.com>
Date: Fri, 16 Sep 2005 01:12:20 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Help by KConfig expansion
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Im all the time going through all the file in the
<KERNEL>/scripts/kconfig without any success. I dont
find any beginning and any end.
I want to expand the Kconfig by a new Attribute. The
property of the attribute is just to give out the
message that is written beside it, to a new component
of the struct menu or struct poperty.

e.g.

config BLA
bool "bla"
auto "blabla"

That what is written beside the "auto" should save in
the Component called char *auto in one of the above
mentioned struct. There must be some changes in the
file zconf.tab.c. Any Suggestion how to this?? 


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
