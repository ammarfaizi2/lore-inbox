Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTEHDFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 23:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTEHDFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 23:05:04 -0400
Received: from fmr05.intel.com ([134.134.136.6]:39118 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263017AbTEHDFD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 23:05:03 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FE1E2@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'jw schultz'" <jw@pegasys.ws>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Swap Compression
Date: Wed, 7 May 2003 20:17:32 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: jw schultz [mailto:jw@pegasys.ws]
>
> While we're having thoughts, this thread keeps me thinking
> it would make sense to have a block device driver that would
> be assigned unused memory.
> 
> I don't mean memory on video cards etc.  I'm thinking of the
> 10% of RAM unused when 1GB systems are booted with MEM=900M
> because they run faster with HIGHMEM turned off.
> 
> The primary use for this "device" would be high priority swap.
> Even with whatever overhead it takes to access it should be
> orders of magnitude faster than any spinning media.

This reminds me of some howto I saw somewhere of someway to
use the MTD drivers to access the unused video RAM and turn
it into swap (maybe with blkmtd?) ... probably it can be done
with that too.

I'd really love it ... I don't know if I can blame it on highmem
or not, but since I enabled it, my system 'feels' slower.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
