Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVHBDeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVHBDeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 23:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVHBDeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 23:34:20 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:60870 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261370AbVHBDeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 23:34:19 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show 
In-reply-to: Your message of "Tue, 02 Aug 2005 13:05:50 +1000."
             <26771.1122951950@ocs3.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Aug 2005 13:32:59 +1000
Message-ID: <27729.1122953579@ocs3.ocs.com.au>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2005 13:05:50 +1000, 
Keith Owens <kaos@sgi.com> wrote:
>The vcsnn value varies.  I traced the dentry parent chain for the
>latest event.  From bottom to top the d_name entries are
>
>  dev, vcs16, vc, class, /.
>
>That makes no sense, why is dev a child of vcs16?  Raw data at the end.

Ignore that bit, I was confusing /dev and dev as a subdir of a sysfs
entry.  The parent chain is right.

