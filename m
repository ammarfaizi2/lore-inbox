Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUIIQ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUIIQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUIIQ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:57:40 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:4085 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S266319AbUIIQ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:57:14 -0400
Message-ID: <41408B41.4030306@am.sony.com>
Date: Thu, 09 Sep 2004 09:56:33 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: What File System supports Application XIP
References: <1094723597.2801.8.camel@laptop.fenrus.com>
In-Reply-To: <1094723597.2801.8.camel@laptop.fenrus.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2004-09-09 at 11:45, colin wrote:
>> Hi,
>> How does ramfs offer application XIP ability?
>> I mean, when the ramfs image is mounted and the application in it is
>> executed,
>> "exec", which is called by sh, should first copy every section of the
>> application to RAM and then jump to the text section.
>> How do I avoid the stage copying text section to RAM?
> 
> this is not how linux works. programs execute directly from the
> pagecache without copy.

Most other filesystems populate the pagecache with I/O, presumably.
In the case of a ramfs, is the page mapped directly from the fs
into the pagecache without a copy?

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
