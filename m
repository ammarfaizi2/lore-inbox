Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVA3Ona@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVA3Ona (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 09:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVA3Ona
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 09:43:30 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:57918 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261707AbVA3On3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 09:43:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oY9S26kPevROxf1Mmg8DlcI9bqFz/g1MIH3SQh5Xvb+L8oWLPS0BycJ0H1VmQWWBzNThx+C65mdzNHk8mk+Fs0vWtcfxEdgEUKOMPv3Huk8dRA+9oeymJjydlGaR7wQCtNxiaCETPjCH89L5G1Uocezl16oNl8qGD3yOZ29tFko=
Message-ID: <9e47339105013006435b7554f6@mail.gmail.com>
Date: Sun, 30 Jan 2005 09:43:28 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970501300322ffdabe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
	 <21d7e9970501300322ffdabe0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 22:22:24 +1100, Dave Airlie <airlied@gmail.com> wrote:
> Just another guess, but Jon could the PCI ROM patch mess up X's access
> via the Int10 handler .. maybe if it isn't mapped properly..?

The ROM patch is inactive until you echo something to the sysfs ROM variable.

> 
> Dave.
> 


-- 
Jon Smirl
jonsmirl@gmail.com
