Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWDXRiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWDXRiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWDXRiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:38:22 -0400
Received: from web50103.mail.yahoo.com ([206.190.38.31]:1372 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751045AbWDXRiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:38:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oXFy8kBjFHDFExk7ke4pbiQvvKs2O3rJVLAKDz8GaNNWAoD12sKAVtw1W+wazEZwKYKJTN4bclIRR1pKSY1fJT99eeDtallLkSYR/ksArvHYGBwgidFRwwLV+URLlq58u8fdIMSsb4zgIrHtF5ithVedwpydOCD0+l2n7ceSYKU=  ;
Message-ID: <20060424173818.10362.qmail@web50103.mail.yahoo.com>
Date: Mon, 24 Apr 2006 10:38:18 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: Problems with EDAC coexisting with BIOS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Gross, Mark" <mark.gross@intel.com>
Cc: bluesmoke-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
In-Reply-To: <1145884747.29648.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> At the very least we should print a warning advising the user that the
> BIOS is incompatible and to ask the BIOS vendor for an update so that
> they can enable error detection and management support. 

Asking for the update might prompt for an update to actually be generated, but I
doubt it.

> 
> Is only the AMI BIOS this braindamaged, should we just blacklist AMI
> bioses in EDAC or is this shared Intel supplied code that may be found
> in other vendors systems.

The engineer who wrote the E752X driver (originally from bluesmoke) was a LinuxBIOS
engineer. We do make some systems with factory BIOS, but not as many as with
LinuxBIOS. We might see these issues on those factory BIOS system, but none that I
know of.

doug thompson

> 
> Alan
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

