Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272290AbTHOW7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272302AbTHOW7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:59:37 -0400
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:11787
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id S272290AbTHOW7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:59:35 -0400
Message-ID: <3F3D65D2.1070700@alpha.dyndns.org>
Date: Fri, 15 Aug 2003 15:59:30 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: remove "Linux 2.4" strings
References: <20030815101143.72bbea51.rddunlap@osdl.org>
In-Reply-To: <20030815101143.72bbea51.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>This patch removes "Linux 2.4" printed strings from a few
>drivers and net protocols.
>
>Instead of changing them to "Linux 2.6", they should just
>be deleted, I think.  Other suggestions?
>
These strings are sometimes useful to maintainers when handling bug 
reports. Vendors and users often replace drivers with out-of-tree 
versions to gain features that aren't included in the in-kernel version 
(because of licensing issues, etc...). I have had this happen with ov511 
a number of times, so I add the "for Linux 2.4" now.

-- 
Mark McClelland
mark@alpha.dyndns.org


