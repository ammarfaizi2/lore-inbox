Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWAOB1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWAOB1h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWAOB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 20:27:37 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:32195 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751143AbWAOB1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 20:27:36 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Quota on xfs vfsroot 
In-reply-to: Your message of "Sat, 14 Jan 2006 10:35:34 BST."
             <Pine.LNX.4.61.0601141033190.25932@yvahk01.tjqt.qr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 12:27:30 +1100
Message-ID: <30975.1137288450@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt (on Sat, 14 Jan 2006 10:35:34 +0100 (MET)) wrote:
>
>>> the xfs_quota manpage says that one needs to use the "root-flags=" boot 
>>> parameter to enable quota for the root filesystem, but I do not see a 
>>> matching __setup() definition anywhere in the fs/xfs/ folder. So, how do I 
>>> have quota activated then?
>>
>>init/do_mounts.c:__setup("rootflags=", root_data_setup);
>>It is a general boot line flag, not xfs specific.
>
>Ah, thank you.
>Weird manpage program wrapped rootflags into "root-\nflags" at EOL, sigh.

One of the many reasons that man pages should have hyphenation turned
off.  In current *roff, the command is '.nh'.  Some older versions of
*roff used '.hy off' or '.hy 0'.

