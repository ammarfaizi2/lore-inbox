Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVBBO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVBBO2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVBBO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:28:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62188 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262592AbVBBO2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:28:15 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <1107271039.15652.839.camel@2fwv946.in.ibm.com>
	<m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
	<20050202154926.18D4.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2005 07:26:06 -0700
In-Reply-To: <20050202154926.18D4.ODA@valinux.co.jp>
Message-ID: <m1pszj9gxt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> I can't understand why ELF format is necessary.

ELF format is not.  However essentially the information an ELF
provides is.  So using an ELF header to convey that information
is a sane choice of data structure.
 
> I think the only necessary information is "what physical address 
> regions are valid to read". This information is necessary for any
> sort of dump tools. (and must get it while the system is normal.)
> The Eric's /proc/cpumem idea sounds nice to me. 

Patches welcome.

Eric

