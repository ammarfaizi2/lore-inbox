Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTJBKdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 06:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTJBKdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 06:33:17 -0400
Received: from mail.g-housing.de ([62.75.136.201]:45985 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262423AbTJBKdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 06:33:16 -0400
Message-ID: <3F7BFEA0.8080503@g-house.de>
Date: Thu, 02 Oct 2003 12:32:00 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030914 Thunderbird/0.3a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Lisa R. Nelson" <lisanels@cableone.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
References: <1065012013.4078.2.camel@lisaserver>
In-Reply-To: <1065012013.4078.2.camel@lisaserver>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lisa R. Nelson wrote:

> [root@localhost root]# cd /
> [root@localhost /]# mkdir junk
> [root@localhost /]# chmod 777 junk

therefore is the sticky bit: users can still create files in the 
directory, but only remove files they are owning:

chmod 1777 /junk

(as your /tmp should be).

do you mean the behaviour has changed for some kernel version? did you 
notice another behaviour with kernel version x.y.?

Thanks,
Christian.


