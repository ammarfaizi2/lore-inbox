Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319378AbSILX5P>; Thu, 12 Sep 2002 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319399AbSILX5P>; Thu, 12 Sep 2002 19:57:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32450 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319378AbSILX5O>;
	Thu, 12 Sep 2002 19:57:14 -0400
Date: Thu, 12 Sep 2002 16:53:52 -0700 (PDT)
Message-Id: <20020912.165352.27501258.davem@redhat.com>
To: sim@netnation.com
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: 802.1q + device removal causing hang
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020912234922.GA1472@netnation.com>
References: <20020911223252.GA12517@erik.ca>
	<20020911.153132.63843642.davem@redhat.com>
	<20020912234922.GA1472@netnation.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Simon Kirby <sim@netnation.com>
   Date: Thu, 12 Sep 2002 16:49:22 -0700

   On Wed, Sep 11, 2002 at 03:31:32PM -0700, David S. Miller wrote:
   
   > Try this:
   > 
   > --- net/8021q/vlan.c.~1~	Wed Sep 11 15:34:49 2002
   > +++ net/8021q/vlan.c	Wed Sep 11 15:34:59 2002
   
   Yup, this fixed it!

Thanks for testing, I'll push this to Marcelo later tonight.
