Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282711AbRK0BZ0>; Mon, 26 Nov 2001 20:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282712AbRK0BZR>; Mon, 26 Nov 2001 20:25:17 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:43430 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282711AbRK0BZK>; Mon, 26 Nov 2001 20:25:10 -0500
Date: Mon, 26 Nov 2001 20:25:09 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no,
        nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: Fix knfsd readahead cache in 2.4.15
Message-ID: <20011126202509.J15582@redhat.com>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no> <15362.53694.192797.275363@esther.cse.unsw.edu.au> <20011126.155347.45872112.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126.155347.45872112.davem@redhat.com>; from davem@redhat.com on Mon, Nov 26, 2001 at 03:53:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 03:53:47PM -0800, David S. Miller wrote:
> There are other problems remaining, this function is a logical
> mess.

Hint: readahead via the page cache is the way to go...

		-ben
-- 
Fish.
