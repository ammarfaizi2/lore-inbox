Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUCBRHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 12:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUCBRHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 12:07:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:35038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261700AbUCBRHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 12:07:49 -0500
Message-Id: <200403021707.i22H7ZE21826@mail.osdl.org>
Date: Tue, 2 Mar 2004 09:07:25 -0800 (PST)
From: markw@osdl.org
Subject: Re: AS performance with reiser4 on 2.6.3
To: Nikita@Namesys.COM
cc: piggin@cyberone.com.au, reiserfs-list@Namesys.COM,
       linux-kernel@vger.kernel.org
In-Reply-To: <16447.35731.535168.298454@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb, Nikita Danilov wrote:
> The rest is not that clear. Probably you workload results in highly
> fragmented file(s). This is consistent with high CPU consumption by
> lookup_extent (http://khack.osdl.org/stp/288741/profile/profile-tick.sort).
> 
> If test doesn't delete its working files before exiting, can you execute
> 
> measurefs.reiser4 -T /device-with-reiser4
> measurefs.reiser4 -D /device-with-reiser4
> 
> and, if number of files on the file system is sane
> 
> measurefs.reiser4 -D -E /device-with-reiser4

Sorry this took a couple of days, but you can view the output of those
commands towards the end of the log file here:
	http://khack.osdl.org/stp/289045/logs/run-log.txt

You should be able to find the output by searching for the 'measurefs'
commands.

Mark
