Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUKOKNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUKOKNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUKOKNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:13:10 -0500
Received: from imap.gmx.net ([213.165.64.20]:52704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261538AbUKOKNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:13:08 -0500
From: Stephan Menzel <stephan42@chinguarime.net>
Organization: Chinguarime
To: linux-kernel@vger.kernel.org
Subject: [FS] New monitor framework in 2.6.10?
Date: Mon, 15 Nov 2004 11:13:06 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151113.06386.stephan42@chinguarime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm maintaining a kernel patch which is monitoring file system activity 
underneath a special directory tree and reporting occuring events via a 
character device to userland where it is processed.
Right now, this patch works via a number of hooks in fs/read-write.c and 
fs/namei.c. 
This is not really efficient at the moment because this way I get an event for 
any written block and not per file which can slow things down a lot.
A couple of days ago I heard rumours about a new feature in 2.6.10 which will 
be exactly for this kind of purpose. Some kind of monitor frameworks that can 
generate events for all sorts of things. Sorry, I don't know any more about 
it.
Is that true? 
Would that be suitable for my task?
And where can I get information about it?

Greetings...

Stephan
