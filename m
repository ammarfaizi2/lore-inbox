Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAHQrH>; Mon, 8 Jan 2001 11:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRAHQq5>; Mon, 8 Jan 2001 11:46:57 -0500
Received: from zeus.kernel.org ([209.10.41.242]:10438 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129735AbRAHQqp>;
	Mon, 8 Jan 2001 11:46:45 -0500
Date: Mon, 8 Jan 2001 16:43:45 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: Re: ext3fs 0.0.5d and reiserfs 3.5.2x mutually exclusive
Message-ID: <20010108164345.A2431@redhat.com>
In-Reply-To: <20010104135044.A5097@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104135044.A5097@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Jan 04, 2001 at 01:50:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 04, 2001 at 01:50:44PM +0100, Matthias Andree wrote:
> I just tried to patch ext3fs 0.0.5d on top of a 2.2.18 that already had
> reiserfs 3.5.28 and failed, there are overlapping patches in fs/buffer.c
> that I cannot resolve for lack of knowledge how buffer.c and journalling
> are supposed to fit together.
> 
> I reported ext3fs and reiserfs incompatibilities quite some time ago.

I know, and the answer is still the same: removing the extra debugging
stuff and buffer.c code from the ext3 patches is on the todo list but
is much lower priority than finishing off the tuning and user-space
code for ext3-1.0.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
