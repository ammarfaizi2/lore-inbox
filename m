Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSHVVIV>; Thu, 22 Aug 2002 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHVVIV>; Thu, 22 Aug 2002 17:08:21 -0400
Received: from tapu.f00f.org ([66.60.186.129]:47509 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S317278AbSHVVIU>;
	Thu, 22 Aug 2002 17:08:20 -0400
Date: Thu, 22 Aug 2002 14:12:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jesper Juhl <jju@dif.dk>
Cc: linux-kernel@vger.kernel.org, nagyt@otpbank.hu, Matt_Domsch@Dell.com
Subject: Re: Problem determining number of CPUs
Message-ID: <20020822211230.GA28099@tapu.f00f.org>
References: <20BF5713E14D5B48AA289F72BD372D6821CBA0@AUSXMPC122.aus.amer.dell.com> <1029940635.7255.185.camel@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029940635.7255.185.camel@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 04:37:14PM +0200, Jesper Juhl wrote:

    In the case of 4 HT capable CPU's it could be reported like

    8 CPUs (4 physical)

    or something like that to indicate that there is nothing wrong and
    the kernel is simply taking advantage of hyperthreading.

Seems like a good idea... people frequently get caught by this
discrepancy in numbers to reporting the number of physical and virtual
processors IMO is a good idea... however, I'm not really sure how this
is determined so someone familiar with the ACPI magic would have to
comment of whether or not this is reasonable :)


  --cw
