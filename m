Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317974AbSGLFJJ>; Fri, 12 Jul 2002 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGLFJI>; Fri, 12 Jul 2002 01:09:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12300 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317974AbSGLFJH>; Fri, 12 Jul 2002 01:09:07 -0400
Message-ID: <3D2E6506.7080006@zytor.com>
Date: Thu, 11 Jul 2002 22:11:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.LNX.4.10.10207112158000.20499-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Nice, so you still have to strip and export to the transport layer.
> 
> Please expand on what you are going to talk to packetized and the 
> associated transport protocol restricted to the scope of storage.
> 
> Next count all the different personalitys associated with the discrete
> transport layer.
> 
> If you are referring to Jens' pktcdvd interface out of block, it is no
> more than a bypass of dealing with scsi.  It would allow direct access to
> the physical transport without portions of OS mucking up things as it does
> now.
> 

I'm talking specifically about ATAPI devices here.  As we have already 
covered, not all ATA devices are ATAPI, but unless I'm completely off 
the wall, ATAPI is SCSI over IDE, and should be able to be driven as 
such.  The lack of access to that interface using the established 
interface mechanisms just bites.

	-hpa


