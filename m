Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWG2HmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWG2HmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWG2HmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:42:00 -0400
Received: from mga08.intel.com ([134.134.136.24]:12134 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422683AbWG2HmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:42:00 -0400
X-IronPort-AV: i="4.07,194,1151910000"; 
   d="scan'208"; a="98165195:sNHT14971089"
Message-ID: <44CB1139.1060403@linux.intel.com>
Date: Sat, 29 Jul 2006 09:41:45 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: David Miller <davem@davemloft.net>, ak@suse.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
References: <200607282045.05292.ak@suse.de> <1154112511.6416.46.camel@laptopd505.fenrus.org> <200607282305.k6SN5e0k015125@turing-police.cc.vt.edu>            <20060728.161215.98863664.davem@davemloft.net> <200607282351.k6SNpinN017263@turing-police.cc.vt.edu>
In-Reply-To: <200607282351.k6SNpinN017263@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 28 Jul 2006 16:12:15 PDT, David Miller said:
> 
>> Your gcc-4.1.1 includes the -fstack-protector feature, but it might
>> not have the gcc bug fix necessary to make that feature work on the
>> kernel compile, which is why the version check is necessary.
> 
> Whee.  A busticated feature - how annoying.

actually it's the kernel that has a differnet ABI than userspace, so it's not entirely gcc
that is to blame.

> 
> Do you happen to know the exact PR# for that one? 

it's gcc PR 28281
