Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSJRNFb>; Fri, 18 Oct 2002 09:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265340AbSJRNFa>; Fri, 18 Oct 2002 09:05:30 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:12300 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265339AbSJRNF3>; Fri, 18 Oct 2002 09:05:29 -0400
Date: Fri, 18 Oct 2002 14:11:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com, greg@kroah.com,
       hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018141126.E1670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Steinmetz <ast@domdv.de>,
	"David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
	greg@kroah.com, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021017.131830.27803403.davem@redhat.com> <3DAF3EF1.50500@domdv.de> <3DAF412A.7060702@pobox.com> <20021017.155630.98395232.davem@redhat.com> <3DAF4382.9020800@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAF4382.9020800@domdv.de>; from ast@domdv.de on Fri, Oct 18, 2002 at 01:10:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 01:10:58AM +0200, Andreas Steinmetz wrote:
> David S. Miller wrote:
> > I'm now leaning more towards something like what Al Viro
> > hinted at earlier, creating generic per-file/fd attributes.
> > This kind of stuff.
> > 
> I'm perfectly happy with anything that doesn't kill LSM.

What about maintaining it out-of-tree?  That's the most widely used
way to keep crap alive..

