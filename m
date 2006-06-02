Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWFBOCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWFBOCO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWFBOCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:02:14 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:12160 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751152AbWFBOCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:02:13 -0400
Date: Fri, 2 Jun 2006 16:02:12 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE (2)
Message-ID: <20060602140212.GA7881@janus>
References: <20060531094626.GA23156@janus> <447DAEC9.3050003@trash.net> <20060531160611.GA25637@janus> <447DC613.10102@trash.net> <20060531172936.GB25788@janus> <447DD66C.30605@trash.net> <20060601091124.GA31642@janus> <447F2537.1080807@trash.net> <20060602123559.GA7505@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602123559.GA7505@janus>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 02:35:59PM +0200, me wrote:

[...]

> This is a tcpdump done after rebooting "posio"
> to 2.6.13.2 showing how it should have looked:

[snip]

The 2.6.13.2 data is inconsistent. The bug appears to be present there at
well after closer examination. So there must be another factor involved
because I have at least one case logged where 2.6.13.2 did work (the
"sirkka" log in my previous mail). Applying your patch on 2.6.13.2
again removes the protocol is buggy messages (when doing a tcpdump)
but the problem of the 10 missing packets persists.

-- 
Frank
