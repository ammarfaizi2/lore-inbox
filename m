Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWHDF5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWHDF5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWHDF5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:57:49 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22934 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161043AbWHDF5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:57:47 -0400
Date: Fri, 4 Aug 2006 14:59:19 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: kmannth@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH] memory hotadd fixes [4/5] avoid check in
 acpi
Message-Id: <20060804145919.34ccbfe0.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060804141705.D5C4.Y-GOTO@jp.fujitsu.com>
References: <1154661826.5925.92.camel@keithlap>
	<20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com>
	<20060804141705.D5C4.Y-GOTO@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 14:46:53 +0900
Yasunori Goto <y-goto@jp.fujitsu.com> wrote:

> BTW, I prefer that we should fix only bug at this time for 2.6.18.
> But, I really confusing that current patches are for only bug fix or
> including for small memory hole case.
> IIRC, small memory hole need more works. So, it should be 2.6.19
> or later. Right?
> Kame-san, could you divide between just fix patch and considering
> small hole case? Or all of patches are for only bug fix?
> 
Hm.

patch [1/5], [2/5], [3/5], [5/5]  are *necessary* bug fixes.
patch [4/5] is for memory hot add with small chunks.

But in other view, it's bug that only the first memory chunk can be added
at hot-add if there is small memory hole in a section 

Thanks,
-Kame

