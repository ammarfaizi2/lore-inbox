Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbRFED4S>; Mon, 4 Jun 2001 23:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbRFED4I>; Mon, 4 Jun 2001 23:56:08 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:28679 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S263165AbRFEDzy>; Mon, 4 Jun 2001 23:55:54 -0400
Date: Tue, 5 Jun 2001 15:55:50 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
Message-ID: <20010605155550.C22741@metastasis.f00f.org>
In-Reply-To: <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15132.15829.322534.88410@pizda.ninka.net>; from davem@redhat.com on Mon, Jun 04, 2001 at 07:03:01PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2001 at 07:03:01PM -0700, David S. Miller wrote:

    The x86 doesn't have dumb caches, therefore it really doesn't
    need to flush anything.  Maybe a mb(), but that is it.

What if the memory is erased underneath the CPU being aware of this?
In such a way ig generates to bus traffic...



  --cw
