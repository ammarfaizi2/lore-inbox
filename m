Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVAJSKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVAJSKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVAJSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:08:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9895 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262400AbVAJSD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:03:26 -0500
Subject: [PATCH 0/6] 2.4.19-rc1 stack reduction patches
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pbadari@us.ibm.com
Content-Type: text/plain
Organization: 
Message-Id: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:35:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I re-worked all the applicable stack reduction patches for 2.4.19-rc1.

I made 6 different patches, one for each area to pick and choose easily.
Here are the stack reductions for each these:

do_execve                    320
number                       100
nfs_lookup                   184
__revalidate_inode           112
rpc_call_sync                144
xprt_sendmsg                 120

If you have any suggestions, more cleanups or re-works, please let me 
know.
 
Thanks,
Badari


