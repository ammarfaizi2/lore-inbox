Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVGONOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVGONOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVGONOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:14:07 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:45766 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261830AbVGONNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:13:45 -0400
Date: Fri, 15 Jul 2005 15:13:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic_file_sendpage
In-Reply-To: <20050715112255.GC2721@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.61.0507151511220.21786@yvahk01.tjqt.qr>
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
 <20050715112255.GC2721@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't know if we want to add this feature, really.  It's such a
>> specialised thing.
>
>With union mount and cowlink, there are two users already.  cp(1)
>could use it as well, even if the improvement is quite minimal.

FTP PUT could use this too - currently, only FTPGETs can use sendfile because 
the target had to be a socket.
(With FTP PUT, the src is a sock, dst is a filedescriptor.)


Jan Engelhardt
-- 
