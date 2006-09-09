Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWIITMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWIITMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 15:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWIITMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 15:12:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:18227 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751374AbWIITMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 15:12:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fdFLJSuIwPBAnJADajnTTk/JS4fDnn3guHkxnb96s2hUfQirxC4BSW5pkRznr9ejZbjBSXhwwdnb/iXoGBIELsf8O0ibPitEM3rHHvxyI7evF4usV1RTW/tfKHpA6vPCwLzEonofFSgNt7vhoY2ADXfHDLSYs08m/9Z9343hQUE=
From: Patrick McFarland <diablod3@gmail.com>
To: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sat, 9 Sep 2006 15:10:19 -0400
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org,
       segher@kernel.crashing.org, davem@davemloft.net
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org> <4503091C.1050501@intel.com>
In-Reply-To: <4503091C.1050501@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091510.20393.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 September 2006 14:34, Auke Kok wrote:
> I'm not sure what bcm43xx chip will work with IA64, or if people actually
> have itanium laptops(!) or MIPS, but for e1000 it definately fixes ordering
> problems on IA64.

Sometimes I wonder, with archs like IA64, why Linus just doesn't pretend IA64 
doesn't exist and refuse to support it. Its such a horribly botched mess from 
what I've seen on LKML.

> Auke


-- 
Patrick McFarland || http://AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

