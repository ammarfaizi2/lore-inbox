Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129122AbRBBNi1>; Fri, 2 Feb 2001 08:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129174AbRBBNiS>; Fri, 2 Feb 2001 08:38:18 -0500
Received: from www.inreko.ee ([195.222.18.2]:48068 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S129158AbRBBNiJ>;
	Fri, 2 Feb 2001 08:38:09 -0500
Date: Fri, 2 Feb 2001 15:48:05 +0200
From: Marko Kreen <marko@l-t.ee>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [BUG] directory renaming/removal
Message-ID: <20010202154804.A5595@l-t.ee>
In-Reply-To: <4260.981120508@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4260.981120508@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Fri, Feb 02, 2001 at 01:28:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I must say that I dont know what the standards say, but...

On Fri, Feb 02, 2001 at 01:28:28PM +0000, David Howells wrote:
>  (1) Linux can't rename directories that are marked as read-only. This is
>      strange because the directories actually being modified _do_ have write
>      permission.

Kernel cant change the ".." entry?

>  (2) You can _remove_ a read-only directory.

Kernel dont need to change the ".." entry?


-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
