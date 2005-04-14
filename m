Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVDNTxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVDNTxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVDNTxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:53:33 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:51588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVDNTxa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:53:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n0bnkzNarE51pXTkfaO7NHgkx7IanOPX3iWO7IWKIfHMHUIz096UsaWUhlE9Hp5wflBYiHQzuu8YcuY9ooicVJySxJhLz9S1+n+Jsb6SbKH77J7fdI9S7nBqGvjtsjkwSWFXF8kCgqBKqqMyXqBt+Yo8r+gwMCoc61Dtix4YLxU=
Message-ID: <17d798805041412536dcd9325@mail.gmail.com>
Date: Thu, 14 Apr 2005 19:53:29 +0000
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel module_list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to access the module list kernel data structure from a
kernel module. If I gather correctly, module_list is the symbol that
is the head pointer of this list.

This module compiles fine but when I try to insmod it, it say
module_list is unresolved symbol.

Does this symbol have to show up in the /proc/ksyms  ? 
It currently show up in the System.map file. 

What do I need to do to access this symbol.

Also, what do the three columns in the System.map file stand for ?
First col looks like the virtual address  and third looks like
function/symbol name. How do I read the second ?

thanks,
Allison
