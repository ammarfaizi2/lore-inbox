Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUJZGMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUJZGMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUJZGL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:11:56 -0400
Received: from fmr10.intel.com ([192.55.52.30]:25270 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S261918AbUJZGLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:11:42 -0400
Message-ID: <417DEA8D.4080307@intel.com>
Date: Tue, 26 Oct 2004 02:11:25 -0400
From: Len Brown <len.brown@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Li, Shaohua" <shaohua.li@intel.com>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space
 for suspend/resume
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com> <20041026051100.GA5844@wotan.suse.de>
In-Reply-To: <20041026051100.GA5844@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What this comes down to is that extended config space is device-specific.
Generic solutions will fail.  Only device drivers will work.

If there are no drivers for PCI bridges to properly save/restore
their config space, then should create them, even if this is all the 
drivers do.

-Len


