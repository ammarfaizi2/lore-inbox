Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSHTWFv>; Tue, 20 Aug 2002 18:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSHTWFv>; Tue, 20 Aug 2002 18:05:51 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:41200 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317402AbSHTWFv>; Tue, 20 Aug 2002 18:05:51 -0400
Date: Tue, 20 Aug 2002 18:09:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: automount doesn't "follow" bind mounts
Message-ID: <20020820180956.L21269@redhat.com>
References: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk> <ajuahu$hf$1@cesium.transmeta.com> <ajucmu$1qd$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ajucmu$1qd$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Aug 20, 2002 at 02:35:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 02:35:26PM -0700, H. Peter Anvin wrote:
> Actually, if you're using autofs v3, which it sounds like you're
> doing, it's even more broken, since autofs v3 doesn't support
> multilevel mounts.

Is there an autofs v4 daemon that's actually released?  The only thing I 
see is code that's over a year old in /pub/linux/daemons/autofs/testing-v4/ 
on kernel.org.  If pre10 is okay, it should be released (at least that 
would explain why we're still shipping v3).

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
