Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJQUZo>; Thu, 17 Oct 2002 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJQUYE>; Thu, 17 Oct 2002 16:24:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51206 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262034AbSJQUYB>;
	Thu, 17 Oct 2002 16:24:01 -0400
Message-ID: <3DAF1DC8.1090708@pobox.com>
Date: Thu, 17 Oct 2002 16:30:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Hm, in looking at the SELinux documentation, here's a list of the
> syscalls they need:
> 	http://www.nsa.gov/selinux/docs2.html
> 
> That's a lot of syscalls :)


Any idea if security identifiers change with each syscall?

If not, a lot of the xxx_secure syscalls could go away...

