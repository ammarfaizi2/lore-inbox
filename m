Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbTCRGev>; Tue, 18 Mar 2003 01:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbTCRGev>; Tue, 18 Mar 2003 01:34:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262196AbTCRGeu>;
	Tue, 18 Mar 2003 01:34:50 -0500
Date: Mon, 17 Mar 2003 22:44:28 -0800 (PST)
Message-Id: <20030317.224428.35337806.davem@redhat.com>
To: vherva@niksula.hut.fi
Cc: ross@willow.seitz.com, linux-kernel@vger.kernel.org
Subject: Re: assertion (newsk->state != TCP_SYN_RECV)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030318064258.GI159052@niksula.cs.hut.fi>
References: <20030312214421.GB20408@willow.seitz.com>
	<1047948907.19314.0.camel@rth.ninka.net>
	<20030318064258.GI159052@niksula.cs.hut.fi>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ville Herva <vherva@niksula.hut.fi>
   Date: Tue, 18 Mar 2003 08:42:58 +0200

   On Mon, Mar 17, 2003 at 04:55:07PM -0800, you [David S. Miller] wrote:
   > Try searching harder, it's a kernel bug which is fixed in
   > current 2.4.21 prepatches.
   
   For reference, the patch is at
   
   http://marc.theaimsgroup.com/?l=linux-kernel&m=104399842612703&w=2
   
   BTW: How severe is the bug? Is it a harmless message, or can it do bad
   things?

We believe that someone could take advantage of it to make a server
get stuck.  So I'd say it's serious.

