Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTEFAia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTEFAia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:38:30 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:39051 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262217AbTEFAi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:38:29 -0400
Message-ID: <3EB706F3.8090701@wmich.edu>
Date: Mon, 05 May 2003 20:50:59 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318
X-Accept-Language: en
MIME-Version: 1.0
To: samba@lists.samba.org
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: subdir problems with 2.5.69 and samba 3.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried both the debian devel and cvs pulls of samba and upon 
upgrading my kernel to 2.5.69 samba no longer allowed access to 
subdirectories of my shares.  Windows gives the error "Directory does 
not exist" yet all files in the share directory in the directory 
supplied by "path" are accessible.  This is even true for guest only 
services with share security so I'm not sure what's going on here.  The 
subdirectories are not symlinks and the permissions are world readable 
world searchable. Is anyone else having this problem or has this 
occurred before so someone can point out what i'm doing wrong.  I'm not 
subscribed to the list so cc all replies and i can supply any further 
info required.

This all worked prior to the kernel upgrade and samba was not changed.

