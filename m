Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSL2W4d>; Sun, 29 Dec 2002 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSL2W4d>; Sun, 29 Dec 2002 17:56:33 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:27889 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261996AbSL2W4c>;
	Sun, 29 Dec 2002 17:56:32 -0500
Date: Sun, 29 Dec 2002 23:53:50 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make i2c use initcalls everywhere
Message-ID: <20021229225350.GE2259@werewolf.able.es>
References: <20021229220436.A11420@lst.de> <20021229222628.GC2259@werewolf.able.es> <20021229223722.A10670@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021229223722.A10670@infradead.org>; from hch@infradead.org on Sun, Dec 29, 2002 at 23:37:22 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.29 Christoph Hellwig wrote:
> On Sun, Dec 29, 2002 at 11:26:28PM +0100, J.A. Magallon wrote:
> > Wil this reach the i2c maintainer or the next auto-generated patch from i2c
> > 2.8.x will undo what you do now and will be sized 4Gb  ?
> 
> There is no maintainer for drivers/i2c/.  The only updates it every got
> was me syncinc with their releases and backing out obvious braindamage.
> 
> > Will this be accepted if I submit it, even independently of the maintainer ?
> > Because I suppose (???) that maintainer is sending changes and they are going
> > to trash...
> 
> Maybe the changes the maintainers of the external i2c code are sending
> _are_ trash?
> 

(just put on the flame war suit...)

Stupid question: why people on http://secure.netroedge.com/~lm78/ is not
smashed with a hammer on the head and 'morally forced' to post, comment, etc.
patches on LKML ? They continue to ship releases, every vendor tracks them,
and every vendor has to correct changes they have not tracked from mainline,
like that old about __exit functions, and now initcalls...

I really do not understand some things about Linux. Some people look like
living in alternative universes...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
