Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315588AbSEQLCZ>; Fri, 17 May 2002 07:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315591AbSEQLCY>; Fri, 17 May 2002 07:02:24 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:50055 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315588AbSEQLCY>; Fri, 17 May 2002 07:02:24 -0400
Message-ID: <3CE4E319.8070800@antefacto.com>
Date: Fri, 17 May 2002 12:01:45 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Still no ramfs usage limits in 2.5.9 or 2.4.19-pre8
In-Reply-To: <20020516164926.GA16670@farnsworth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Farnsworth wrote:
> David Gibson produced a patch about 18 months ago that added usage limits
> to ramfs.  <http://ozlabs.org/people/dgibson/dwg-ramfs.patch>
> 
> Through 2.4.10, the AC kernel series carried this patch.
> 
> Linus' kernel from 2.4.11 onward adopted only one line from the
> patch, the following attribution comment:
> 	"Usage limits added by David Gibson, Linuxcare Australia."
> 
> The usage limit code is missing, however.
> 
> Was this a simple mistake that has been overlooked?  Or are there
> drawbacks to applying the patch that keep it out of the mainstream
> kernels?
> 
> -Dale Farnsworth

Linus said the code should be kept as simple
as possible because it's only an example file system.
However simple should also not mean practically useless.
Also as of 2.5 it's mandatory, so it should get the
limit code IMHO. There are also a few other patches
floating around for ramfs:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100553363224376&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=98701101629272&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100753902321780&w=2

Padraig.

