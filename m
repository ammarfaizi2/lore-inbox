Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRBTS3Z>; Tue, 20 Feb 2001 13:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRBTS3G>; Tue, 20 Feb 2001 13:29:06 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:60420 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129611AbRBTS2x>;
	Tue, 20 Feb 2001 13:28:53 -0500
Date: Tue, 20 Feb 2001 19:28:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dan Christian <dac@ptolemy.arc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang on mount, 2.4.2-pre4, VIA
Message-ID: <20010220192848.B6846@suse.cz>
In-Reply-To: <20010220101622.A18117@ptolemy.arc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220101622.A18117@ptolemy.arc.nasa.gov>; from dac@ptolemy.arc.nasa.gov on Tue, Feb 20, 2001 at 10:16:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 10:16:22AM -0800, Dan Christian wrote:

> Hello,
>   I just tried upgrading to 2.4.2-pre4 from 2.4.1 and get a hang when
> mounting the file systems.  I have the same problem with 2.4.1-ac18.
> 
> The system is a single processor P3 and uses a VIA chipset (Tyan
> something-or-other).  DMA, multi-sector IO, and 32bit sync are enabled
> using hdparm (just before the hang).

Remove the hdparm command. It isn't needed.

> There are two Ultra-66 drives
> attached to one IDE channel and a CD-RW on a second IDE channel.
> 
> The distribution is RH7 with recent security patches and modutils
> 2.4.2.  The kernel was built with kgcc.
> 
> Has anybody else seen this?

I assume these problems weren't present before?

> I'm not on the list.  Please CC me on any replies.

What's your southbridge chip (lspci ...)? What are the drives (hdparm -i ...)?

I can send you the VIA latest drivers if you are interested in trying
whether they'll help.

-- 
Vojtech Pavlik
SuSE Labs
