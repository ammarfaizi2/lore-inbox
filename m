Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUHBBU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUHBBU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 21:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUHBBU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 21:20:28 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15749 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266187AbUHBBU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 21:20:26 -0400
Message-ID: <410D96DC.1060405@namesys.com>
Date: Sun, 01 Aug 2004 18:20:28 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can think of this as chroot on steroids.  The idea is to use the 
concept of views, in which one specifies a description of what in the fs 
should be visible in the view, and extend them to become "tracing views" 
which automate the creation of "viewprints", which contain what a 
process attempted to access during some period when it was being 
supervised, and then use these viewprints to conveniently specify a view 
that defines what the process should be allowed to access.  It is not 
that this is better than chroot, it is that it is to be made much less 
human work to use than chroot, as chroot is used much too rarely in 
practice.

Another concept of the proposal is that of process oriented security, as 
opposed to the object oriented security usual to filesystems.  These 
viewprints will be associated with the executables of the processes 
being isolated, not with the files, and this is academically amusing as 
a distinction I think.

You can find details of our proposal at 
www.namesys.com/blackbox_security.html.  You have to be able to perform 
the work in the US (a government requirement for this contract), which 
means that I cannot use my current Russian staff (the US State 
department is making it hard to get visas these days).

If you have an interest in filesystems, views, security, and the linux 
kernel, you might find it fun.  It should be a nice opportunity for an 
ambitious young software architect, and I like to think that the people 
who work for me learn a bit.  The infrastructure you will help spec out 
will be useful for lots of other purposes besides security (version 
control, search refinement, etc.)  The work will be GPL'd, etc.

If you would like to know more about namesys and reiser4, you can look 
at www.namesys.com

Please email me directly if it interests you rather than just responding 
to the thread.

Hans
