Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWF2Ksu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWF2Ksu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWF2Kst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:48:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:61660 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932556AbWF2Kss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:48:48 -0400
Message-ID: <44A3AFFB.2000203@sgi.com>
Date: Thu, 29 Jun 2006 12:48:27 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Luck, Tony" <tony.luck@intel.com>, John Daiker <jdaiker@osdl.org>,
       John Hawkes <hawkes@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>	 <yq04py4i9p7.fsf@jaguar.mkp.net> <1151578928.23785.0.camel@localhost.localdomain>
In-Reply-To: <1151578928.23785.0.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-06-29 am 05:37 -0400, ysgrifennodd Jes Sorensen:
>> You have my vote for that one. Anything else is just going to cause
>> those broken userapps to continue doing the wrong thing. We should
>> really do this on all archs though.
> 
> No need, all current mainstream architectures expose a constant user HZ.

But you are still going to have the issue where someone installs their
own kernel and apps will break because of this? Getting the distros to
stop publishing a constant HZ is probably the right solution, but more
difficult :(

Cheers,
Jes
