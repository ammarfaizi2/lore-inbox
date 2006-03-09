Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWCIROu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWCIROu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWCIROu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:14:50 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:934 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1750847AbWCIROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:14:50 -0500
Subject: Re: filldir[64] oddness
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Dave Jones <davej@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060309170740.GA9876@redhat.com>
References: <20060309042744.GA23148@redhat.com>
	 <20060308.203204.115109492.davem@davemloft.net>
	 <20060309044025.GS27946@ftp.linux.org.uk>
	 <1141923743.17294.8.camel@localhost.localdomain>
	 <20060309170740.GA9876@redhat.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 09:15:14 -0800
Message-Id: <1141924514.17294.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 12:07 -0500, Dave Jones wrote:

>  > About half of the ~50 reports I've looked at so far in their database
>  > have been false positives.  In most of those cases, it's not obvious how
>  > a checker might have gotten them right instead, though.
> 
> It seems to stumble quite a bit when faced with things that are
> free'd when refcounts drop to zero. (skbs, and kobjects).

Yes, or (in my case) stuff like "when this variable has value X, that
pointer can't possibly be NULL".

	<b

