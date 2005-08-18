Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVHRXCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHRXCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVHRXCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:02:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:50133 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932283AbVHRXCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:02:44 -0400
Date: Fri, 19 Aug 2005 09:02:35 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rename locking functions - fix a blunder in initial patches
Message-ID: <20050819090235.D4075975@wobbly.melbourne.sgi.com>
References: <200508182309.35274.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200508182309.35274.jesper.juhl@gmail.com>; from jesper.juhl@gmail.com on Thu, Aug 18, 2005 at 11:09:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 11:09:33PM +0200, Jesper Juhl wrote:
> ...
> have if getting rid of the defines is prefered, then that's something that
> can easily be done later.

I tend to agree with Christoph on this - this level of internal API
churn is unnecessary and can be error prone (as you cunningly showed ;)
- please just leave it as is, and move on to greener pastures.

thanks.

-- 
Nathan
