Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSJVW47>; Tue, 22 Oct 2002 18:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSJVW47>; Tue, 22 Oct 2002 18:56:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:22673 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262243AbSJVW46>;
	Tue, 22 Oct 2002 18:56:58 -0400
Subject: Re: 3COM 3C990 NIC
From: "David S. Miller" <davem@rth.ninka.net>
To: David Dillow <dillowd@y12.doe.gov>
Cc: Christopher Keller <cnkeller@interclypse.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3DB4D9F8.F86ABA4@y12.doe.gov>
References: <1035002976.3086.4.camel@maranello.interclypse.net> 
	<3DB4D9F8.F86ABA4@y12.doe.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 16:13:41 -0700
Message-Id: <1035328421.16085.21.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 21:54, David Dillow wrote:
> It will support zero-copy TCP, TCP segmentation offload, and when DaveM's
> IPSEC is in, I'll be able to do hardware offload for that as well.

Please tell me what the interface is to offload IPSEC transformations
to the card.  What information does the card need to properly transform
the packet and what transforms are supported?

Currently there are no plans for an offload strategy, because we lack
knowledge in the area of exactly what cards provide.

