Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSJQXNy>; Thu, 17 Oct 2002 19:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbSJQXNx>; Thu, 17 Oct 2002 19:13:53 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:10232 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262580AbSJQXNl>; Thu, 17 Oct 2002 19:13:41 -0400
Date: Thu, 17 Oct 2002 16:10:20 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com, ast@domdv.de,
       hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017161020.E26442@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
	ast@domdv.de, hch@infradead.org, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021017.131830.27803403.davem@redhat.com> <3DAF3EF1.50500@domdv.de> <3DAF412A.7060702@pobox.com> <20021017.155630.98395232.davem@redhat.com> <20021017230912.GF1682@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021017230912.GF1682@kroah.com>; from greg@kroah.com on Thu, Oct 17, 2002 at 04:09:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Thu, Oct 17, 2002 at 03:56:30PM -0700, David S. Miller wrote:
> > 
> > I'm now leaning more towards something like what Al Viro
> > hinted at earlier, creating generic per-file/fd attributes.
> > This kind of stuff.
> 
> I think either Al, or Chris Wright, have mentioned that stackable
> filesystems would remove all of the LSM VFS hooks, and also enable a lot
> of other cool things to happen.  Unfortunately, that's not going to make
> it into 2.6, but in the future is probably the way to go.

I think it's more like filters than true stacking.  If I understand the
problem correctly, true generic stacking introduces cache coherency fun.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
