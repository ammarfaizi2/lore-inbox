Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRA3LSD>; Tue, 30 Jan 2001 06:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbRA3LRx>; Tue, 30 Jan 2001 06:17:53 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:59653 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129704AbRA3LRj>; Tue, 30 Jan 2001 06:17:39 -0500
Date: Wed, 31 Jan 2001 00:17:37 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Rasmus Andersen <rasmus@jaquet.dk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
Message-ID: <20010131001737.C6620@metastasis.f00f.org>
In-Reply-To: <rasmus@jaquet.dk> <20010129224311.H603@jaquet.dk> <13240.980842736@warthog.cambridge.redhat.com> <14966.32188.408789.239466@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14966.32188.408789.239466@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 30, 2001 at 12:39:24AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 12:39:24AM -0800, David S. Miller wrote:

    Please see older threads about this, it has been discussed to
    death already (hint: sizeof(atomic_t), sizeof(unsigned long)).

can we not define a macro so architectures that can do do atomically
inc/dec with unsigned long will? otherwise it uses the spinlock?


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
