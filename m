Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTFMIeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTFMIeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:34:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4528
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265269AbTFMIeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:34:20 -0400
Subject: Re: PROBLEM: fatal error with nForce2 system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mok@imsb.au.dk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6F57D57C-9D02-11D7-AF71-003065529A02@stofanet.dk>
References: <6F57D57C-9D02-11D7-AF71-003065529A02@stofanet.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055493950.5169.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 09:45:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-12 at 19:19, Morten Kjeldgaard wrote:
>   I first reported the problem to nVidia, and they were very quick to 
> repond. I was in contact with a very helpful engineer, and after some 
> experimentation we concluded that the problem is probably not in their 
> drivers, since the machine crashes under the same circumstances without 
> the nvidia drivers loaded. However, I have only seen error messages in 
> the syslog when the nvidia driver is loaded, but that is most likely a 
> coincidence. Sometimes the machine freezes instantly, other times it 
> goes down in a less spectacular manner...

The hang and the Nvidia driver crash may be unrelated problems
unfortunately. The first candidate is probably to run memtest86 on
the system, and then to check the usual suspects (fan, psu voltage). 

A crash dump with Nvidia stuff having been loaded is I'm afraid
worthless to anyone but Nvidia in most situations

