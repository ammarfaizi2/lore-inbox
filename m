Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSHTWRd>; Tue, 20 Aug 2002 18:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSHTWRd>; Tue, 20 Aug 2002 18:17:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317458AbSHTWRc>; Tue, 20 Aug 2002 18:17:32 -0400
Message-ID: <3D62C0EC.5010707@zytor.com>
Date: Tue, 20 Aug 2002 15:21:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: automount doesn't "follow" bind mounts
References: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk> <ajuahu$hf$1@cesium.transmeta.com> <ajucmu$1qd$1@cesium.transmeta.com> <20020820180956.L21269@redhat.com> <3D62C039.60206@zytor.com> <20020820182000.M21269@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Aug 20, 2002 at 03:18:33PM -0700, H. Peter Anvin wrote:
> 
>>The problem is that autofs v4 is completely unmaintained at the moment.
> 
> 
> Is there a todo list or known set of outstanding problems with it?
> 

Not that I know of.  I don't believe the code has been analyzed for
races; in fact, it seems to me that there are inherent races in mount
point deconstruction.

	-hpa


