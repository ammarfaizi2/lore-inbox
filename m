Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTLVMDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 07:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTLVMDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 07:03:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264401AbTLVMDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 07:03:52 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: tsuchiya@labs.fujitsu.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <3FE67362.2070704@labs.fujitsu.com>
References: <3FDD7DFD.7020306@labs.fujitsu.com>
	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>
		 <3FDF95EB.2080903@labs.fujitsu.com> <3FE0E5C6.5040008@labs.fujitsu.com>
	 <1071782986.3666.323.camel@sisko.scot.redhat.com>
	 <3FE62999.90309@labs.fujitsu.com>  <3FE67362.2070704@labs.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1072094621.1967.6.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Dec 2003 12:03:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-12-22 at 04:30, Tsuchiya Yoshihiro wrote:

> I tried it with IDE disk and it failed also. It was run on
> ext2 on 2.4.23. So it's not a SCSI problem.

OK, I'll try your script with a 2.4.21 or 2.4.23 kernel to see if we can
reproduce this here.  In the mean time, could you possibly try a 2.4.24
kernel, just in case the clear_inode race has something to do with this?

Thanks,
 Stephen

