Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTAFONQ>; Mon, 6 Jan 2003 09:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAFONQ>; Mon, 6 Jan 2003 09:13:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54148
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264844AbTAFONP>; Mon, 6 Jan 2003 09:13:15 -0500
Subject: Re: Fwd: File system corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: krushka@iprimus.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <0301062138130A.01466@paul.home.com.au>
References: <0301062138130A.01466@paul.home.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041865580.17472.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 15:06:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 11:38, Paul wrote:
> Hi,
> 
> I sent the following email regarding a suspected bug to the IDE maintainer 
> mentioned in the DOCs but haven't got a response.
> 
> Can anyone point me in the right direction here?

Sandisk I think. Looking at the corruption pattern and actual disk
behaviour might be informative. Its possible the vendor has done
something silly like teach the firmware 'tricks' about FAT file
systems that depend on exact windows behaviour I guess.

Might be interesting to see what it does given a totally not FAT
environment (eg fill the disk start to end with each sector filled
with its sector number repeatedly) and see what comes out the other
end.
 
Alan

