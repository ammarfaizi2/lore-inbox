Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUJWOvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUJWOvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUJWOrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:47:23 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:19166 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261203AbUJWOoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:44:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BmFOSV7UIhdNqgtFyIoXMnuPnCE9+qrdRdoFBbAHU/kE0J3NBTH05Q0AaOYpYxILqcQzOoK8RneZGwk3+nGdu3BsAqj5/VACkiDwpUrs8nBOnxmCX1JmhktYMKV/Il3efS2cb2FUY6LxvOUgBMB3JZzoo2Q/Z+BrrVNHJi+Z7NM=
Message-ID: <9e47339104102307441066e4e4@mail.gmail.com>
Date: Sat, 23 Oct 2004 10:44:30 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
In-Reply-To: <20041023143912.GA32532@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <9e473391041023073578b11eb6@mail.gmail.com>
	 <20041023143912.GA32532@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 15:39:12 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> agpgart.o will load without any hardware present in 2.6, and you don't
> need the lowlevel drivers.  2.4 was slightly messed up in this regard.

What about the group that will complain about the 30K of memory wasted?

-- 
Jon Smirl
jonsmirl@gmail.com
