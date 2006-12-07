Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031792AbWLGH0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031792AbWLGH0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031795AbWLGH0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:26:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:41062 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031792AbWLGH0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:26:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gj/OXYBwwjxKRB1jbYLi7QYLPGRVHDoV9bNoR7ycchw0YfmZyJ1kf7+NEXgBnbBza1L6KRHJmMxavtIDMpO8lcs28Fdqz/LgY7JXCXNNTK0l4ybeuf0r099qN9ZRJAyPB3/Z+lhH75QBl1YCYACUE0ON0EzNEabkyPFRrDBuZaw=
Message-ID: <a10e25a30612062326t6a238b15v9b81de7f092337a1@mail.gmail.com>
Date: Wed, 6 Dec 2006 23:26:50 -0800
From: "Kunal Trivedi" <ktrivedilkml@gmail.com>
To: linuxkernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: Possible Bug in VM accounting (Committed_AS) on x86_64 architecture ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
Sorry for late followup on this.

I did found the problem. It was 32 bit binary running on 64 bit arch.
Actually main kernel had fixed this problem in 2.6.14
(http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2fd4ef85e0db9ed75c98e13953257a967ea55e03)
But apparently CentOS has not ported it yet.

Thanks for your reply

-Kunal
