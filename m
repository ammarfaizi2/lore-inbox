Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUESL0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUESL0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUESLYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:24:51 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30371 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264155AbUESLXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:23:19 -0400
Date: Wed, 19 May 2004 21:22:14 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Jakub Jelinek <jakub@redhat.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519212214.F574345@wobbly.melbourne.sgi.com>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz> <20040519105805.GK30909@devserv.devel.redhat.com> <20040519110105.GC7836@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040519110105.GC7836@fi.muni.cz>; from kas@informatics.muni.cz on Wed, May 19, 2004 at 01:01:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 01:01:05PM +0200, Jan Kasprzak wrote:
> ...
> 	Yes, XFS. I will look at it  in the evening.
> 
> Thanks,

The only spot needing fixing is that one pointed out above; from
a quick look ssize_t seems to be used correctly in the rest of
the XFS sendfile code.

cheers.

-- 
Nathan
