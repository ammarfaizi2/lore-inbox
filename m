Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279599AbRJ2XMu>; Mon, 29 Oct 2001 18:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279596AbRJ2XMd>; Mon, 29 Oct 2001 18:12:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23801
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279597AbRJ2XMT>; Mon, 29 Oct 2001 18:12:19 -0500
Date: Mon, 29 Oct 2001 15:12:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: elko <elko@home.nl>
Cc: Hugh Dickins <hugh@veritas.com>, Marko Rauhamaa <marko@pacujo.nu>,
        linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
Message-ID: <20011029151243.G20280@mikef-linux.matchmail.com>
Mail-Followup-To: elko <elko@home.nl>, Hugh Dickins <hugh@veritas.com>,
	Marko Rauhamaa <marko@pacujo.nu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110292144120.1085-100000@localhost.localdomain> <01103000034207.13457@ElkOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01103000034207.13457@ElkOS>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 12:03:42AM +0100, elko wrote:
> On Monday 29 October 2001 22:45, Hugh Dickins wrote:
> > On Mon, 29 Oct 2001, Marko Rauhamaa wrote:
> > > I noticed that I need a pseudodevice that opens normally but blocks
> > > all reads (and writes). The only way out would be through a signal.
> > > Neither /dev/zero nor /dev/null block, but is there some other
> > > standard device that would do the job?
> > >
> > > If there isn't, writing such a pseudodevice would be trivial. What
> > > should it be called? Any chance of including that in the kernel?
> >
> > /dev/never
> 
> sorry, the bait was too obvious: /dev/microsoft

No,

cat /dev/microsoft > /dev/never

;)
