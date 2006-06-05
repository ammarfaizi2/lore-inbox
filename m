Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751290AbWFESy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWFESy4 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWFESy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:54:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:16061 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751290AbWFESyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:54:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=In7a8YISefNLi14VK2HqAgkTRXKCVXM/XYaOjtMGLRC8ClKEhpfJ+q7I4geC3JXgI77teon3F8r+aVtV15K4o/eUTXthuNeeSkwHdhfklWNlWqYELWM8d+Z7+DDc2DsA5kz7dBUsW4w6aRGLoOvwqS7G6p98S5qRUfv+m+obhwU=
Message-ID: <4ae3c140606051154w4ec42f9fj19bb2cca0e55ff58@mail.gmail.com>
Date: Mon, 5 Jun 2006 14:54:54 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to dump the page addresses of a kmem_cache object?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I allocated a kmem_cache object with function kmem_cache_create().
After I do kmem_cache_alloc(), several pages should be assigned to
this kmem_cache object.

My question is: how can I dump the addresses of the pages allocated to
this cache? Can someone give me a rough idea or direct me to somewhere
to find the solution?

Thanks in advance for your help!

Xin
