Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVCLGYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVCLGYb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 01:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVCLGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 01:24:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:27841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261880AbVCLGYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 01:24:30 -0500
Date: Fri, 11 Mar 2005 22:23:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: mike kravetz <kravetz@us.ibm.com>
Cc: paulus@samba.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 NUMA memory fixup
Message-Id: <20050311222358.7f9697ae.akpm@osdl.org>
In-Reply-To: <20050311221110.GG6360@w-mikek2.ibm.com>
References: <16942.30144.513313.26103@cargo.ozlabs.ibm.com>
	<20050310023613.23499386.akpm@osdl.org>
	<16945.23578.505529.220972@cargo.ozlabs.ibm.com>
	<20050311221110.GG6360@w-mikek2.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike kravetz <kravetz@us.ibm.com> wrote:
>
> Here is another version of the patch.  This one gets the cell sizes
>  before extracting the cells.  I have made this change to existing
>  code in the file, as well as the code I added.  This works fine on
>  my 720, but so did the previous patch. :)  I'd appreciate it if
>  someone could touch test this on a machine known to break with
>  the previous version (such as G5).

That works, thanks.
