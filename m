Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUAPJ61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 04:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbUAPJ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 04:58:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31954 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265346AbUAPJ6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 04:58:23 -0500
Date: Fri, 16 Jan 2004 15:33:10 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd?
Message-ID: <20040116100310.GB1276@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <400762F9.5010908@comcast.net> <20040116094037.GA1276@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116094037.GA1276@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 03:10:37PM +0530, Maneesh Soni wrote:
[...]
> 
> Can you elaborate on the recreation scenario a little bit more or if possible

Hi Walt,

One more thing I wanted to ask you is that whether you unload any module/driver
in the system. Because unloading a module will cause the corresponding 
sysfs directory from the system through sysfs_remove_dir_call(). Or any other
activities with sysfs filesystem.

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
