Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCBTS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCBTS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWCBTS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:18:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6091 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932180AbWCBTSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:18:25 -0500
Date: Thu, 2 Mar 2006 11:15:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Andi Kleen <ak@suse.de>, Steffen Weber <email@steffenweber.net>,
       linux-kernel@vger.kernel.org, J.E.J.Bottomley@hansenpartnership.com,
       stable@kernel.org
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
In-Reply-To: <9a8748490603021023j4c9af732y9d52a2a4a6f4ee97@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603021113280.5829@schroedinger.engr.sgi.com>
References: <44071AF3.1010400@steffenweber.net>  <4407347F.1000209@steffenweber.net>
  <200603021916.50053.jesper.juhl@gmail.com>  <200603021917.52268.ak@suse.de>
 <9a8748490603021023j4c9af732y9d52a2a4a6f4ee97@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Jesper Juhl wrote:

> include/linux/types.h already has the BITSPER_BYTE define in -mm.

Its already in 2.6.16-rc.

christoph@schroedinger:~/software/linux$ grep BITS_PER_BYTE */include/linux/*
linux-2.6.16-rc2/include/linux/types.h:#define BITS_PER_BYTE 8
linux-2.6.16-rc3/include/linux/types.h:#define BITS_PER_BYTE 8
linux-2.6.16-rc4/include/linux/types.h:#define BITS_PER_BYTE 8
linux-2.6.16-rc5/include/linux/types.h:#define BITS_PER_BYTE 8

(dont have rc1 and 15 in that directory)

