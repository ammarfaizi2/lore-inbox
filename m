Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271213AbTGWSvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271197AbTGWSvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:51:55 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:65030 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271213AbTGWSvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:51:52 -0400
Date: Wed, 23 Jul 2003 20:06:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bernie@develer.com: Kernel 2.6 size increase]
Message-ID: <20030723200658.A27856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20030723195355.A27597@infradead.org> <20030723195504.A27656@infradead.org> <20030723115858.75068294.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030723115858.7506829I4.davem@redhat.com>; from davem@redhat.com on Wed, Jul 23, 2003 at 11:58:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 11:58:58AM -0700, David S. Miller wrote:
> > Sorry, this actually already Cc'ed lkml :)  Still the netdev folks
> > should read it, too.
> 
> Well, we gained some code and a little bit of data, but
> the BSS was cut in half which I think deserves noticing :-)
> 
> Also, he should analyze the amount of code that actually
> gets executed for various tasks, comparing 2.4.x to 2.5.x
> 
> I'd take a half-meg code size hit if it meant that all
> the normal code paths got cut in half :-)

half a megabyte more codesize is a lot if you're based on flash.
I know you absolutely disliked Andi's patch to make the xfrm subsystem
optional so we might need find other ways to make the code smaller
on those systems that need it.  Now I could talk a lot but I'm really
no networking insider so it's hard for me to suggest where to start.
I'll rather look at the fs/ issue but it would be nice if networking
folks could do their part, too.
