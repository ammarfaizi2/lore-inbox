Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756771AbWKTEAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbWKTEAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 23:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756840AbWKTEAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 23:00:44 -0500
Received: from bay0-omc1-s32.bay0.hotmail.com ([65.54.246.104]:21488 "EHLO
	bay0-omc1-s32.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1756771AbWKTEAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 23:00:43 -0500
Message-ID: <BAY107-F318881FF4ADDFBA789F97BABED0@phx.gbl>
X-Originating-IP: [69.51.119.190]
X-Originating-Email: [eyubo@hotmail.com]
From: "e m" <eyubo@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: path_lookup for executable
Date: Mon, 20 Nov 2006 04:00:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 20 Nov 2006 04:00:42.0794 (UTC) FILETIME=[72E9F8A0:01C70C58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get inode for an executable program. For example, I wish to 
get inode for /usr/jdk/bin/java file in a module. The following call always 
return an error. Is there a way to get the inode of current process, 
assuming I have access to "current"

PLEASE CC' eyubo@hotmail.com your answers.

Thanks
Eyub

      err = path_lookup("/ /usr/jdk/bin/java", 
LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);

    path_release(&nd);

_________________________________________________________________
Talk now to your Hotmail contacts with Windows Live Messenger. 
http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://get.live.com/messenger/overview

