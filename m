Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289070AbSAIXCc>; Wed, 9 Jan 2002 18:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSAIXCV>; Wed, 9 Jan 2002 18:02:21 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:51351
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289072AbSAIXCL>; Wed, 9 Jan 2002 18:02:11 -0500
Date: Wed, 9 Jan 2002 17:46:37 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109174637.A1742@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Matthew Kirkwood <matthew@hairy.beasts.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020109154742.B28755@thyrsus.com> <Pine.LNX.4.33.0201092238100.29914-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201092238100.29914-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Wed, Jan 09, 2002 at 10:41:59PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood <matthew@hairy.beasts.org>:
> > The underlying problem is that dmidecode needs access to kmem, and I
> > can't assume that the person running my configurator will be root.
> 
> But you can "su -c" (also sudo, I suppose).  If that person
> doesn't have root, then building a kernel isn't going to do
> them much good.

We've been over this already.  No, the configurator user should *not* have
to su at any point before actual kernel installation.  Bad practice, 
no doughnut.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The power to tax involves the power to destroy;...the power to
destroy may defeat and render useless the power to create...."
	-- Chief Justice John Marshall, 1819.
