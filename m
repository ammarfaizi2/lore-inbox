Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312193AbSCTVPb>; Wed, 20 Mar 2002 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSCTVPM>; Wed, 20 Mar 2002 16:15:12 -0500
Received: from ztxmail02.ztx.compaq.com ([161.114.1.206]:37134 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S312190AbSCTVPD>; Wed, 20 Mar 2002 16:15:03 -0500
Date: Wed, 20 Mar 2002 15:07:42 -0600
From: Stephen Cameron <steve.cameron@compaq.com>
To: linux-kernel@vger.kernel.org
Cc: manon@manon.de
Subject: Re: Hooks for random device entropy generation missing in cpqarray.c
Message-ID: <20020320150742.A4450@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@compaq.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Manon Goo wrote:

> All hooks for the random ganeration (add_blkdev_randomness() ) 
> are ignored=20 in the cpqarray / ida  driver

Try OR-ing in SA_SAMPLE_RANDOM in the call to request_irq().

You don't say what kernel you're using, I think
this is already in the latest 2.2, 2.4, 2.5 kernels,
if I remember right... I see it in my copy of 2.2.21-pre3 
anyway.

-- steve

