Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUL2OG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUL2OG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUL2OG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:06:56 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:59212 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261351AbUL2OGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:06:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aK84pEgwLcnJi/dQidyrXNYsNm77RE8FUbIIohkouZ8ySpVZ6RcW5iGxHqOVMAa6KPNz3I1ouYcg53YVk5BImUTOLLULKyfRKMowSSutFqvDcXnmP+pL0q2vX9IYPvW6of1+kUcgzmk/3XFYLgd28Q8sSUEw2bXrhfw2GxTqDsA=
Message-ID: <2cd57c900412290606f356334@mail.gmail.com>
Date: Wed, 29 Dec 2004 22:06:54 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Subject: Re: Memory management in Linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41D2ABA8.2080906@euroweb.net.mt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41D2ABA8.2080906@euroweb.net.mt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 14:05:44 +0100, Josef E. Galea
<josefeg@euroweb.net.mt> wrote:
> Hi all,
> 
> Does the linux kernel allow a process to handle its own memory pages
> instead of using the kernel's virtual memory manager?
> 
> Thanks & Happy Holidays
> Josef


That's quite related to ``adaptive page replacement''. Linux doesn't
support that at present imho.

--cqh


-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
