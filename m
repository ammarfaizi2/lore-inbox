Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUIGIcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUIGIcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 04:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUIGIcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 04:32:50 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:7369 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S267708AbUIGIcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 04:32:48 -0400
Message-ID: <413D7204.8090502@tu-harburg.de>
Date: Tue, 07 Sep 2004 10:32:04 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904181220.B16644@infradead.org> <20040904172223.GC9765@wohnheim.fh-wedel.de> <20040904182556.A16774@infradead.org>
In-Reply-To: <20040904182556.A16774@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>
>>>Could you give some context please?
>
> 
> Oh, I know what union mounts are.  But I wonder who's hacking on them
> as they need some major VFS surgey to get right.
> 

Ok, first sorry for the late reply. I'm working on a vfs-based 
union-mount implementation for linux. The focus is on the basic 
functionality explained by McKusick [1] without a need for a new 
separate filesystem, without options like "before". "after", "in 
between" or something like that, with permanent whiteouts if the fstype 
supports them. For the copyup I plan to use Jörn's patch.
At the moment some basic stuff (actually the unions) is working, so you 
actually can "see" something but I don't think that the patches are 
ready for being posted now. Please relax and wait a few weeks because I 
have to go back to university for some final exams. After that I'm back 
for some more full-time hacking on union-mounts.

[1]:http://www.usenix.org/publications/library/proceedings/neworl/full_papers/mckusick.a

Regards,
Jan
