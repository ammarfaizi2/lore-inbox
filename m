Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbVCKFTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbVCKFTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbVCKFTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:19:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:26256 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263184AbVCKFTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:19:08 -0500
Date: Fri, 11 Mar 2005 16:18:06 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>, Roland Dreier <roland@topspin.com>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       willy@debian.org
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-ID: <20050311161806.A2976910@wobbly.melbourne.sgi.com>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <52fyz2938t.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <52fyz2938t.fsf@topspin.com>; from roland@topspin.com on Thu, Mar 10, 2005 at 09:10:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 09:10:42PM -0800, Roland Dreier wrote:
>     Andrew> (Why do they want to do this anyway?)
> 
> Neither use seems really fundamental.  The XFS use is explicitly
> inside #ifdef DEBUG and seems to be used only for assertions.

Right, our peeking at that value is debug-only (so usually its not
even compiled in).  I wouldn't go out of your way to add a more
permanent interface just for this, we can live without it.

cheers.

-- 
Nathan
