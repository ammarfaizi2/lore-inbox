Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTFQRwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFQRwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:52:50 -0400
Received: from boden.synopsys.com ([204.176.20.19]:15006 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S264486AbTFQRws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:52:48 -0400
Message-ID: <3EEF58A6.4050907@Synopsys.COM>
Date: Tue, 17 Jun 2003 20:06:30 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030613
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Flameeyes <daps_mls@libero.it>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.71, fbconsole: No boot logo?
References: <Pine.LNX.4.44.0306162133520.12997-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0306162133520.12997-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> Its a bug in cfbimgblt.c. In cfb_imageblit you have a test 
> 
> } else if (image->depth == bpp)
> 
> Its should be 
> 
> } else if (image->depth <= bpp)
> 
> instead. At present the logo will only show up when the framebuffer depth 
> matches the image's depth. cfb_imageblit supports displaying images of 
> equal or lesser depths than the framebuffer.
> 

Tux is back.


Many thanx

Harri

