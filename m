Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAMXF5>; Sat, 13 Jan 2001 18:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRAMXFs>; Sat, 13 Jan 2001 18:05:48 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:6672 "HELO kamov.deltanet.ro")
	by vger.kernel.org with SMTP id <S129771AbRAMXF3>;
	Sat, 13 Jan 2001 18:05:29 -0500
Date: Sun, 14 Jan 2001 01:01:25 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64 compile fix
Message-ID: <20010114010125.M2734@ppetru.net>
In-Reply-To: <20010113152104.B2734@ppetru.net> <14944.56558.198555.536993@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <14944.56558.198555.536993@pizda.ninka.net>; from davem@redhat.com on Sat, Jan 13, 2001 at 02:55:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 02:55:42PM -0800, David S. Miller wrote:
> Petru Paler writes:
>  > -       struct dqblk d;
>  > +       struct dqblk32 d;
> 
> What does this fix?  Things compile just fine without
> it and looking at the code it was intended to be of
> the original type.
> 
> Please explain exactly what submitted patches fix in
> the future, thanks.

Sorry, my fingers slipped and I sent the mail too fast :(

Trying to compile 2.4.0-ac8 resulted in an error about
storage size of variable d not being known (I don't have the
exact error at hand, the network connectivity to that server
is down right now). Changing it to dqblk32 got it to compile.

Am I doing something else wrong ?

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
