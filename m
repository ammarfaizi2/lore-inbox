Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbTGHWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbTGHWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:15:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12718
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267771AbTGHWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:13:12 -0400
Subject: Re: Forking shell bombs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Valdez <maxvalde@fis.unam.mx>
Cc: system_lists@nullzone.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057684703.6241.3.camel@garaged.homeip.net>
References: <20030708202819.GM1030@dbz.icequake.net>
	 <20030708193401.24226.95499.Mailman@lists.us.dell.com>
	 <20030708202819.GM1030@dbz.icequake.net>
	 <5.2.1.1.2.20030708235404.02b9ec80@192.168.2.130>
	 <1057684703.6241.3.camel@garaged.homeip.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057703101.5652.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 23:25:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 18:18, Max Valdez wrote:
> I set the ulimit -u 1791
> and the box keeps running(2.4.20-gentoo-r5) , but we still need the
> problem corrected, any other user can run ther DOS and crash the box, is
> there any way to set ulimits for all users fixed ??, not by sourcein a
> bashrc or something like that ?? because the user can delete the line on
> .bashrc and thats it

You can set the limits using the pam limits module and set the hard
limit so the user cannot revert it. Or with -ac just set no overcommit
and it seems fine

