Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279661AbRJ3AEu>; Mon, 29 Oct 2001 19:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279654AbRJ3AEk>; Mon, 29 Oct 2001 19:04:40 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:49703 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279653AbRJ3AE0>; Mon, 29 Oct 2001 19:04:26 -0500
Date: Mon, 29 Oct 2001 19:05:02 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029190502.N25434@redhat.com>
In-Reply-To: <20011029185158.L25434@redhat.com> <20011029.155559.64018347.davem@redhat.com> <20011029185743.M25434@redhat.com> <20011029.160123.35683974.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029.160123.35683974.davem@redhat.com>; from davem@redhat.com on Mon, Oct 29, 2001 at 04:01:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 04:01:23PM -0800, David S. Miller wrote:
> Why would it take you two days to put together a test case for
> something so "trivial"?  Don't be rediculious.

Well, maybe you like under testing things, but personally I don't.  What 
do you want a microoptimization?  Get real, you don't accept 
microoptimizations to networking code without numbers from the bigger 
picture.  So that means running real tests on real applications like 
Oracle or RHDB.  I think you'll find that the cross cpu case will be 
quite happy with a range flush.  Heck, it's the kind of IPI that can 
even legally be asynchronous.  Why don't you go do something useful 
like implement that instead of making me spend my time to correct other 
people's obvious mistakes?

		-ben
-- 
Fish.
