Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTLXQs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 11:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTLXQs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 11:48:57 -0500
Received: from main.gmane.org ([80.91.224.249]:14042 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263661AbTLXQs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 11:48:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: allow process or user to listen on priviledged ports?
Date: Wed, 24 Dec 2003 17:43:09 +0100
Message-ID: <bscg1m$1eg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

don't blame me for asking such a question in the LKML, but i already 
asked it in other linux-newsgroups. i haven't got any real answer yet.

my problem is, that i want an application to listen on a priviledged 
port (e.g. port 80) and to run as a "normal" unpriviledged user (e.g. 
wwwrun). Well - how? The application is not a C/C++-application, so i 
cannot ask the author (myself) to implement a mechanism to switch the 
userid (e.g. like apache does it).

So is there any machanism to bind that permission (to listen on a 
priviledged tcp-port) to a specific user or a specific process?

The application is written in Java. Of course Java could implement 
userid-switching, but the linux could also have an ACL for that. So 
please don't answer with "go and ask Sun for that feature". I already 
considered that.

Thx
   Sven


