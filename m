Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbTGHJjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbTGHJjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:39:16 -0400
Received: from inergen.sybase.com ([192.138.151.43]:14543 "EHLO
	inergen.sybase.com") by vger.kernel.org with ESMTP id S266919AbTGHJjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:39:13 -0400
Date: Tue, 8 Jul 2003 11:53:45 +0200
From: Wim ten Have <wtenhave@sybase.com>
To: linux-kernel@vger.kernel.org
Cc: linux-aio@kvack.org
Subject: Re: Bug fix in AIO initialization
Message-Id: <20030708115345.5e6e5bbc.wtenhave@sybase.com>
In-Reply-To: <41F331DBE1178346A6F30D7CF124B24B2A4880@fmsmsx409.fm.intel.com>
References: <41F331DBE1178346A6F30D7CF124B24B2A4880@fmsmsx409.fm.intel.com>
Reply-To: Wim ten Have <wtenhave@sybase.com>
Organization: Sybase Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Is there a definition how long system calls take when i issue
   asynchronous read/write requests?  The purpose is to not block
   but occasionally i measure up to 100's of milliseconds before
   the request is accepted or returns that there are currently
   no resources making me try again.  Is this normal?

-- 
-- Wim ten Have. 		AUDIX: 245 2981
Phone: (+31) 346 582981, Fax: Euro (+31) 346 552884, Room (+31) 346 558415
