Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUDBLeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 06:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUDBLeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 06:34:22 -0500
Received: from mxintern.kundenserver.de ([212.227.126.201]:51933 "EHLO
	mxintern.schlund.de") by vger.kernel.org with ESMTP id S262497AbUDBLeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 06:34:21 -0500
Message-ID: <406D4FB6.4070301@snakefarm.org>
Date: Fri, 02 Apr 2004 13:34:14 +0200
From: Carsten Gaebler <ezinye-zinto@snakefarm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-xfs@oss.sgi.com
Subject: Re: 2.4.25 XFS can't create files
References: <406D20FE.8040701@snakefarm.org> <20040402093238.GA28931@dingdong.cryptoapps.com>
In-Reply-To: <20040402093238.GA28931@dingdong.cryptoapps.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> I suspect it's not MPT related.  I'm not farmiliar with stock 2.4.25
> but assume the XFS merge went OK and everything is sane.  Any chance
> you can test with a CVS kernel from oss.sgi.com to rule out the
> (probably minor) differences there?

The SGI kernel works fine. Thanks for the hint.

> strace shows open/creat failing?

Yes.

open("/mnt/xfs/foo", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 
0666) = -1 EACCES (Permission denied)

 > there are also no ACLs and/or
> security modules involved are there?

Nope.

cg.
