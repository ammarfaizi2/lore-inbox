Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUDNR2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUDNR2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:28:02 -0400
Received: from mail.tmr.com ([216.238.38.203]:25092 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264288AbUDNR17 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:27:59 -0400
Date: Wed, 14 Apr 2004 13:25:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Paulo Marques <pmarques@grupopie.com>
cc: Guillaume@Lacote.name,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
In-Reply-To: <407D3231.2080605@grupopie.com>
Message-ID: <Pine.LNX.3.96.1040414132403.22330C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Paulo Marques wrote:

> Guillaume Lacôte wrote:
> 
> >>>Oops ! I thought it was possible to guarantee with the Huffman encoding
> >>>(which is more basic than Lempev-Zif) that the compressed data use no
> >>>more than 1 bit for every byte (i.e. 12,5% more space).
> 
> WTF??
> 
> Zlib gives a maximum increase of 0.1%  + 12 bytes (from the zlib manual), which 
> for a 512 block will be a 2.4% guaranteed increase.
> 
> I think that zlib already does the "if this is bigger than original, just mark 
> the block type as uncompressed" algorithm internally, so the increase is minimal 
> in the worst case.

I kind of think that the compression, even negative, is wanted here to
assist in obfuscation.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

