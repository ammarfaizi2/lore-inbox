Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317698AbSHLJR1>; Mon, 12 Aug 2002 05:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSHLJR1>; Mon, 12 Aug 2002 05:17:27 -0400
Received: from k100-159.bas1.dbn.dublin.eircom.net ([159.134.100.159]:33295
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S317698AbSHLJR0>; Mon, 12 Aug 2002 05:17:26 -0400
Message-ID: <3D577DFF.5010309@corvil.com>
Date: Mon, 12 Aug 2002 10:21:03 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
References: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>	 <3D57782E.5090009@corvil.com> <1029148667.16424.144.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-08-12 at 09:56, Padraig Brady wrote:
> 
>>Anyone care to clarify which filesystems don't
>>have unique inode numbers. I always thought you
>>could uniquely identify any file using a device,inode
>>tuple? Fair enough proc is "special" but can/should
>>you not assume unique inodes within all other filesystems?
> 
> 
> 2.4 functions correctly here in all the stuff I've looked at.

cool.

> I can't speak for 2.5. In the 2.4 case you must be holding the files open 
 > during the comparison. Some file systems like MSDOS invent inodes as
 > they go, never issuing the same one to two objects at the same time but
 > happily reissuing different inode numbers the next time around.

Sure, no hardlinks so who cares what the number is, as long
as it's unique.

> That breaks NFS but not much else

hmm..

thanks,
Pádraig.

