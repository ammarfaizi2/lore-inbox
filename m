Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130367AbRABVqB>; Tue, 2 Jan 2001 16:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130287AbRABVpv>; Tue, 2 Jan 2001 16:45:51 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:51418 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130367AbRABVpi>; Tue, 2 Jan 2001 16:45:38 -0500
Date: Tue, 2 Jan 2001 21:30:45 +0100
To: Elmer Joandi <elmer@ylenurme.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: prerelease total nonmodular compile, compiler warnings, linking errors
Message-ID: <20010102213045.A2103@storm.local>
Mail-Followup-To: Elmer Joandi <elmer@ylenurme.ee>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101021548480.5324-300000@yle-server.ylenurme.sise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101021548480.5324-300000@yle-server.ylenurme.sise>; from elmer@ylenurme.ee on Tue, Jan 02, 2001 at 03:56:54PM +0200
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 03:56:54PM +0200, Elmer Joandi wrote:
> 
> compiling everything builtin, (exept RCPCI, which does not compile)
> 
> linking errors:
> drivers/ieee1394/ieee1394.a is not made, quick hack to use .o to see other
> errors.

You're then using the ieee1394.o module object which doesn't include the
hardware and highlevel drivers.  I've sent a patch to Linus already and
cc'd the mailing list also.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
