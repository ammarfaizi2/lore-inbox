Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTDUVaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbTDUVaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:30:04 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:57224 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S262594AbTDUVaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:30:03 -0400
Message-ID: <3EA465AA.6000507@acm.org>
Date: Mon, 21 Apr 2003 16:42:02 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Experimental IPMI driver
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on a new version of the IPMI driver.  It's actually
not terribly different than the old version (no functional or interface
differences), but has the following differences:

    * It will properly parse ACPI tables to find IPMI interfaces (the
      old driver had some ACPI parsing code, but it was broken).
    * It supports a SMIC interface.
    * It has a socket interface to IPMI.

I'm putting it out for people to beat on, so have at it!

You can get it from SourceForge at
http://sourceforge.net/projects/openipmi/, under "Experimental Driver". 
There are 2.5.68 and 2.4.20 versions.

-Corey

