Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUBSQKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267342AbUBSQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:10:41 -0500
Received: from smtp.terra.es ([213.4.129.129]:52087 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S267327AbUBSQKe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:10:34 -0500
Date: Thu, 19 Feb 2004 17:00:51 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Nur Hussein <obiwan@slackware.org.my>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security update patch to 2.6.3 for mremap()?
Message-Id: <20040219170051.6b97f6bf.diegocg@teleline.es>
In-Reply-To: <1077201466.1636.19.camel@sophia.localdomain>
References: <1077201466.1636.19.camel@sophia.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 19 Feb 2004 22:37:46 +0800 Nur Hussein <obiwan@slackware.org.my> escribió:

>                                                                                                                              I noticed however, that a fix to the same problem in 2.4.25 sent by
> Andrea Arcangeli adds only one line to a different section of code:
>  
> http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4

AFAIK, the 2.4 path should be this one, shouldn't it?
http://linux.bkbits.net:8080/linux-2.4/patch@1.1323?nav=index.html|ChangeSet@-2d|cset@1.1323

>                                                                                                                              Is this line missing from 2.6.3, or did Andrew Morton's fixes address
> the problem already?

The 2.6 should be this one (comitted 15 days ago):
http://linux.bkbits.net:8080/linux-2.5/diffs/mm/mremap.c@1.38?nav=index.html|src/|src/mm|hist/mm/mremap.c
2.6.3 is safe, it seems

PD: Your mailer is doing very weird things.

	Diego Calleja


