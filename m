Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTAPOuN>; Thu, 16 Jan 2003 09:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbTAPOuN>; Thu, 16 Jan 2003 09:50:13 -0500
Received: from unthought.net ([212.97.129.24]:7065 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S267121AbTAPOuM>;
	Thu, 16 Jan 2003 09:50:12 -0500
Date: Thu, 16 Jan 2003 15:59:08 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: argv0 revisited...
Message-ID: <20030116145908.GF8621@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com> <20030115191942.GD47@DervishD> <b04dqu$4f5$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b04dqu$4f5$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 07:46:38PM +0000, Miquel van Smoorenburg wrote:
> In article <20030115191942.GD47@DervishD>,
> DervishD  <raul@pleyades.net> wrote:
> >> > of init. Remember, is not any program, is an init. Should be a more
> >> > clean way, I suppose :??
> >> I don't think is that big a deal ... if you startup the system normally,
> >> sooner or later, /proc is going to be mounted. A [quickie] variation is:
> >
> >    Yes, I know, and that's one option, but I would like to avoid the
> >mounting. Not a big deal, anyway, as you say. The only thing is that
> >it won't work in kernels without proc enabled (yes, there are people
> >without 'proc', size issues, I suppose, etc...).
> 
> I assume that init is passed on the kernel command line like
> init=/what/ever, right ?
> 
> Why not make that INIT=/what/ever, then make this /sbin/init:

Why not make a kernel patch that sets the INIT environment variable for
the init process ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
