Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVAMVSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVAMVSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVAMVG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:06:56 -0500
Received: from mproxy.gmail.com ([216.239.56.249]:40029 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261690AbVAMVGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:06:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nm97phNlGC5dFbPeIN34KbmAsruqFoVEGfdsY2c6dX0vDl8ghb9sUAAXI5ZpWYRXhRkhjBFjP/jg0JrurQbwKsOiKPuv4pfXQFXR4tErKjE81OxiBS24jAvsIPkP6SgY6ZObsQXoorU5ZZXQmjsh1i/rZXzOS/FyrSSICblXRW0=
Message-ID: <21d7e997050113130659da39c9@mail.gmail.com>
Date: Fri, 14 Jan 2005 08:06:09 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: covici@ccs.covici.com
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helge.hafting@hist.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16870.21720.866418.326325@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on Thursday 01/13/2005 Helge Hafting(helge.hafting@hist.no) wrote
>  > 2.6.10 boots fine, but is killed by the X server when it
>  > tries to initialize my PCI radeon 9200 SE.  This problem exists
>  > in 2.6.9 too, but not in 2.6.8.1.  So I'm stuck with that version currently.
>  >
>  > The problem seems to be access to the card bios, X uses
>  > int10 bios calls to initialize the card.
>  >

Do you have DRM enabled if so can you turn it off.. same with radeonfb
or vesafb...

Dave.
