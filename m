Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbTGXDdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 23:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271066AbTGXDdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 23:33:51 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:48864 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S271055AbTGXDdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 23:33:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Johannes Halmann <softpro@gmx.net>
Reply-To: ahljoh@uni.de
To: linux-kernel@vger.kernel.org
Subject: Re: directory inclusion in ext2/ext3
Date: Thu, 24 Jul 2003 05:48:34 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030724034833.5D63B371@mendocino>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003 03:00:17 +0200 Mike Fedyk wrote:
>> my idea of solving this is to have
>> an inclusion directive in directory-files...
>> 
>> has nobody ever felt the lack of such functionality??

> What exactly does this help you to do?
> What do you want to accomplish?

hmm, i have a lot of huge files on different hard drives and wish to access 
them in a uniform fashion. i would like to sort ALL files in subdirectories 
but have no need for an LVM, RAID or similar. for example:

/mnt/drive1/category1
/mnt/drive1/category2
/mnt/drive2/category1
/mnt/drive2/category2

(the data is so huge, that it is not possible to always merge categories on a 
single disk!)
what i would like to do now is to be able to display all files of "cat1" and 
"cat2" respectively in "/mnt/union/category1" and "/mnt/union/category2". yet 
i don't wish to simply link the directories as this would complicate access 
with growing number of hard drives the data is spread on!

it's a bit weird to explain, i hope it's understandable now :-)))

Johannes
