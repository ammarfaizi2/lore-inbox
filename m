Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbRAZRh1>; Fri, 26 Jan 2001 12:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131655AbRAZRhR>; Fri, 26 Jan 2001 12:37:17 -0500
Received: from zeus.kernel.org ([209.10.41.242]:36048 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129999AbRAZRhE>;
	Fri, 26 Jan 2001 12:37:04 -0500
Date: Fri, 26 Jan 2001 17:34:17 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, V Ganesh <ganesh@veritas.com>,
        lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
Subject: Re: inode->i_dirty_buffers redundant ?
Message-ID: <20010126173417.A14943@redhat.com>
In-Reply-To: <20010125164432.A12984@redhat.com> <Pine.LNX.4.21.0101251907110.11559-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101251907110.11559-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jan 25, 2001 at 07:11:01PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 25, 2001 at 07:11:01PM -0200, Marcelo Tosatti wrote:
> 
> We probably want another kind of "IO buffer" abstraction for 2.5 which can
> support buffer's bigger than PAGE_SIZE. 
> 
> Do you have any thoughts on that, Stephen? 

XFS is already doing this, with pagebufs being used in their cache,
and kiobufs used for the IO submission.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
