Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHUAcE>; Tue, 20 Aug 2002 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSHUAcE>; Tue, 20 Aug 2002 20:32:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54545 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317622AbSHUAcE>; Tue, 20 Aug 2002 20:32:04 -0400
Message-ID: <3D62E06D.8030105@zytor.com>
Date: Tue, 20 Aug 2002 17:35:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: stoffel@lucent.com
CC: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: automount doesn't "follow" bind mounts
References: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk>	<ajuahu$hf$1@cesium.transmeta.com>	<ajucmu$1qd$1@cesium.transmeta.com>	<20020820180956.L21269@redhat.com> <15714.57320.918331.932316@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stoffel@lucent.com wrote:
>>>>>>"Benjamin" == Benjamin LaHaise <bcrl@redhat.com> writes:
>>>>>
> 
> Benjamin> Is there an autofs v4 daemon that's actually released?  The
> Benjamin> only thing I see is code that's over a year old in
> Benjamin> /pub/linux/daemons/autofs/testing-v4/ on kernel.org.  If
> Benjamin> pre10 is okay, it should be released (at least that would
> Benjamin> explain why we're still shipping v3).
> 
> Well, HPA says that pre10 has some serious problems, but it was the
> only version I could get to work with our Solaris NIS environment and
> out NetApps reliably.  I'd release the darn thing and let people send
> in patches as needed.
> 

I said I *think* it is racy, mostly because noone has ever bothered
showing it to the contrary, and because I have failed to see how it
*couldn't* be.

	-hpa


