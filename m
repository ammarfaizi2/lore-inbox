Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbTCRGcQ>; Tue, 18 Mar 2003 01:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbTCRGcQ>; Tue, 18 Mar 2003 01:32:16 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:31691 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262178AbTCRGcP>; Tue, 18 Mar 2003 01:32:15 -0500
Date: Tue, 18 Mar 2003 08:42:58 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "David S. Miller" <davem@redhat.com>
Cc: Ross Vandegrift <ross@willow.seitz.com>, linux-kernel@vger.kernel.org
Subject: Re: assertion (newsk->state != TCP_SYN_RECV)
Message-ID: <20030318064258.GI159052@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"David S. Miller" <davem@redhat.com>,
	Ross Vandegrift <ross@willow.seitz.com>,
	linux-kernel@vger.kernel.org
References: <20030312214421.GB20408@willow.seitz.com> <1047948907.19314.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047948907.19314.0.camel@rth.ninka.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 04:55:07PM -0800, you [David S. Miller] wrote:
> On Wed, 2003-03-12 at 13:44, Ross Vandegrift wrote:
> > I've recently noticed these messages bouncing up in my logs every now
> > and again.  It's always with a particular machine, one that runs 2.4.20.
> > 
> > Google turns up one other post, made on Mon Jan 13
> > (http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week02/0308.html)
> > but no responses or explanations followed.
> 
> Try searching harder, it's a kernel bug which is fixed in
> current 2.4.21 prepatches.

For reference, the patch is at

http://marc.theaimsgroup.com/?l=linux-kernel&m=104399842612703&w=2

BTW: How severe is the bug? Is it a harmless message, or can it do bad
things?


-- v --

v@iki.fi
