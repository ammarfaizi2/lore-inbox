Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSJQXDe>; Thu, 17 Oct 2002 19:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262381AbSJQXDd>; Thu, 17 Oct 2002 19:03:33 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7695 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262364AbSJQXDd>;
	Thu, 17 Oct 2002 19:03:33 -0400
Date: Thu, 17 Oct 2002 16:09:12 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, ast@domdv.de, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017230912.GF1682@kroah.com>
References: <20021017.131830.27803403.davem@redhat.com> <3DAF3EF1.50500@domdv.de> <3DAF412A.7060702@pobox.com> <20021017.155630.98395232.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017.155630.98395232.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 03:56:30PM -0700, David S. Miller wrote:
> 
> I'm now leaning more towards something like what Al Viro
> hinted at earlier, creating generic per-file/fd attributes.
> This kind of stuff.

I think either Al, or Chris Wright, have mentioned that stackable
filesystems would remove all of the LSM VFS hooks, and also enable a lot
of other cool things to happen.  Unfortunately, that's not going to make
it into 2.6, but in the future is probably the way to go.

thanks,

greg k-h
