Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbTEIJBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTEIJBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:01:34 -0400
Received: from siaag2ac.compuserve.com ([149.174.40.133]:64472 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262393AbTEIJBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:01:33 -0400
Date: Fri, 9 May 2003 05:11:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200305090513_MC3-1-3814-65C8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   Does a layered filesystem get all requests for ext3 IO if it's above
>> it then, or does someone have to manually mount it for each volume?
>
> after you mounted it you get all I/O requests below the mountpoint.

  So it's not 'layer a filesystem over another one' it's 'mount an
instance of a filesystem over another instance' then.  And this means
it gets mounted twice with two different mountpoint names, right?


