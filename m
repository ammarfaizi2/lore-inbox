Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSDMSxJ>; Sat, 13 Apr 2002 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSDMSxI>; Sat, 13 Apr 2002 14:53:08 -0400
Received: from tapu.f00f.org ([66.60.186.129]:46806 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S293337AbSDMSxH>;
	Sat, 13 Apr 2002 14:53:07 -0400
Date: Sat, 13 Apr 2002 11:52:49 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: lk@tantalophile.demon.co.uk, ak@suse.de, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020413185249.GA31470@tapu.f00f.org>
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de> <20020412222252.A25184@kushida.apsleyroad.org> <20020412.143150.74519563.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 02:31:50PM -0700, David S. Miller wrote:

    If you need to depend upon a consistent snapshot of what some
    other thread writes into a file, you must have some locking
    protocol to use to synchronize with that other thread.

Appends of small-writes (for whatever reason) seems to be atomic,
AFAIK nobody gets corrupt apache logs for example.



  --cw
