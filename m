Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVGCOKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVGCOKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVGCOKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 10:10:33 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:61880 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261445AbVGCOK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 10:10:29 -0400
Date: Sun, 3 Jul 2005 16:10:28 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging? (2)
Message-ID: <20050703141028.GB1298@janus>
References: <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 03:24:04PM +0200, Miklos Szeredi wrote:
> 
> > But that's not really acceptable (see previous audit case) unless FUSE
> > refuses to mount on non-leaf dirs.
> 
> I don't think the audit case is important.  It's easy to work around
> it manually by the sysadmin, and for the automatic case it doesn't
> really matter (as detailed above).

Note that the audit case "as user" is less important than the root case. I
consider the latter very important and EACCES will break it when FUSE
permits mounting on non-leaf dirs.

-- 
Frank
