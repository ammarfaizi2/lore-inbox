Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVDLGxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVDLGxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVDLGxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:53:45 -0400
Received: from main.gmane.org ([80.91.229.2]:1005 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262021AbVDLGxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:53:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Subject: Re: Overcommit_memory logic fails when swap is off
Date: Mon, 11 Apr 2005 20:58:47 +0200
Message-ID: <d3eh7m$9ep$1@sea.gmane.org>
References: <42525107.6060807@egholm-nielsen.dk> <1113233235.9885.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.242.189.63
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
In-Reply-To: <1113233235.9885.40.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

>>As I can see, the patch never made it in 2.4.x, right?!
>>So, I would like a diff - if still possible :-)
> I submitted it ages ago but it was rejected and punted to 2.6. The 2.4
> support is available in Red Hat Enterprise Linux 3, so you can pull it
> out of the source rpms on the ftp site or out of Centos etc
Bingo. I seem to have found what looks like it in:
linux-2.4.21-selected-ac-bits.patch
linux-2.4.21-tunable-overcommit.patch

But many of the other patches messes with mmap.c, as well :-), so I 
guess there is some tracking assignment ahead...

But nevertheless, thanks for pointing me to the source...

BR,
  Martin Egholm

