Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSARDG6>; Thu, 17 Jan 2002 22:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290588AbSARDGs>; Thu, 17 Jan 2002 22:06:48 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:62645 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S290587AbSARDGb>; Thu, 17 Jan 2002 22:06:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: o(1) to the rescue
Date: Thu, 17 Jan 2002 22:06:29 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, Davide Libenzi <davidel@xmailserver.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020118030630.AA34757D57@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this with and without the o(1) scheduler (J0).

Create a dir full of 1 meg or so jpegs.  Fire up kde.  Try using the Tools/Create image gallery.  
With the standard scheduler linux is unusable - it stalls for most of the processing time for 
each image.   With o(1) its just a little jerky - still usable though (a gallery is building as I 
type this).  

Xmms playing to a arts server running with real time priority experienced no dropouts during 
the process.

This is on 2.4.17 no preempt or low latency patches applied.

Real improvement - nice work,

Ed Tomlinson
