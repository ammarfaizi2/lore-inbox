Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317632AbSGJVdL>; Wed, 10 Jul 2002 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317633AbSGJVdK>; Wed, 10 Jul 2002 17:33:10 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:22261 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317632AbSGJVdJ>; Wed, 10 Jul 2002 17:33:09 -0400
Date: Wed, 10 Jul 2002 17:35:55 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020710173555.D2005@redhat.com>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <3D2CA6E3.CB5BC420@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D2CA6E3.CB5BC420@zip.com.au>; from akpm@zip.com.au on Wed, Jul 10, 2002 at 02:28:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 02:28:03PM -0700, Andrew Morton wrote:
> > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> > these been quantified?
> 
> Not that I'm aware of.  And I'd regard any such claims with some
> scepticism.

The most obvious one is the reduced latency of select/poll timeouts.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
