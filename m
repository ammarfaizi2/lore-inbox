Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSGYQ22>; Thu, 25 Jul 2002 12:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGYQ22>; Thu, 25 Jul 2002 12:28:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315413AbSGYQ20>; Thu, 25 Jul 2002 12:28:26 -0400
Message-ID: <3D4027DB.3090805@zytor.com>
Date: Thu, 25 Jul 2002 09:31:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
References: <Pine.LNX.4.44.0207251127150.17906-100000@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> Ideally, the ABI layer would be maintained and packaged separately from
> both the kernel and glibc to avoid gratuitous changes from either side.
> 

I disagree.  The ABI is a product of the kernel and should be attached 
to it.  It is *not* a product of glibc -- glibc is a consumer of it, as 
are any other libcs.

	-hpa

