Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318112AbSHDGrN>; Sun, 4 Aug 2002 02:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSHDGrM>; Sun, 4 Aug 2002 02:47:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318112AbSHDGrM>; Sun, 4 Aug 2002 02:47:12 -0400
Message-ID: <3D4CCEA6.2020408@zytor.com>
Date: Sat, 03 Aug 2002 23:50:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, ftpadmin@kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
References: <21455.1028188535@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> patch-2.4.19-rc5.gz has been there for 25 minutes but the .bz2 file and
> the signature have not been created yet.  Is there a problem with the
> automatic conversion and signing code on master?

The sign/convert/upload machinery is sometimes slow when it is either 
transferring large files, or doing its daily "rsync --checksum" for 
paranoia's sake.  The latter happens at 00:00 local time, currently 
17:00 UTC.

	-hpa

