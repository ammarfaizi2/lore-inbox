Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTCFDNF>; Wed, 5 Mar 2003 22:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTCFDNF>; Wed, 5 Mar 2003 22:13:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267708AbTCFDNE>;
	Wed, 5 Mar 2003 22:13:04 -0500
Message-ID: <3E66BF21.4010608@pobox.com>
Date: Wed, 05 Mar 2003 22:23:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Making it easy to add system calls
References: <3E66A44A.6000808@mvista.com>
In-Reply-To: <3E66A44A.6000808@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch makes it impossible to tell at an easy glance which syscall 
is which number.  The current code makes it quite obvious which numbers 
are assigned to which syscalls, and which syscall numbers are available 
for use.  We lose valuable information with this patch, even if it does 
wind up to be functionally equivalent.

	Jeff




