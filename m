Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTDHDNs (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263906AbTDHDNs (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:13:48 -0400
Received: from cs.columbia.edu ([128.59.16.20]:12520 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S263905AbTDHDNr (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 23:13:47 -0400
Subject: vfs level undelete support?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049772192.1243.186.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 23:23:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would there be any interest in a patch that added undelete support to
the VFS.  the idea would be that when one unlink's a file, instead of it
being deleted, it is "moved" to "/.undelete/d_put path of dentry",
coupled with a daemon that manages the size (maintains a quota per uid
by deleting old files).

It would appear to be an easy CONFIG level option, as it would just be
do this, or normal unlink(), and would work for every fs, as well as not
needing and LD_PRELOAD.

It seems pretty simple to hack up, just wondering if there's any
interest?  

thanks,

shaya



