Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUH1D4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUH1D4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUH1D4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:56:08 -0400
Received: from samadams.xtreamlok.com ([203.27.107.2]:40222 "EHLO
	samadams.xtreamlok.com") by vger.kernel.org with ESMTP
	id S266491AbUH1D4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:56:05 -0400
Message-ID: <413002C2.7090607@biodome.org>
Date: Sat, 28 Aug 2004 13:57:54 +1000
From: QuantumG <qg@biodome.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Milo Rogers <rogers@isi.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: reverse engineering pwcx
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu> <20040828014931.GM24018@isi.edu> <412FF888.8090307@biodome.org> <20040828033552.GN24018@isi.edu>
In-Reply-To: <20040828033552.GN24018@isi.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2004 03:57:56.0615 (UTC) FILETIME=[339C9170:01C48CB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Milo Rogers wrote:

>	If the "now clearly false" is meant to be a consequence of the
>entropy measurements poster I referred to, I wouldn't jump the gun.
>On reflection, it's entirely natural for a decompressed stream to
>examine less entropy than the corresponding compressed stream!
>  
>

First let me apologize to the list.  I get carried away now and then :)

Actually I was refering to the fact that these algorithms are not 
"decompression" in any way shape or form.  These cameras don't capture 
640x480 images, compress them in hardware, transfer the data over a USB 
cable for the driver to then "decompress".  They capture at some lower 
resolution (160x120 has been claimed) and the driver simply interpolates 
the data to produce the claimed resolution.  There is nothing "true" 
about the 640x480 resolution at all.

So yeah, Logitech is making false claims to their customers and seeing 
as they get their chips from Philips I'm thinking they are responsible.

Trent
