Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVK2U5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVK2U5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVK2U5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:57:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40932 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932397AbVK2U47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:56:59 -0500
Date: Wed, 30 Nov 2005 07:56:50 +1100
From: Nathan Scott <nathans@sgi.com>
To: Luca <kronos@kronoz.cjb.net>
Cc: John Hawkes <hawkes@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: unable to use dpkg 2.6.15-rc2
Message-ID: <20051130075650.A7058184@wobbly.melbourne.sgi.com>
References: <20051121100820.D6790390@wobbly.melbourne.sgi.com> <20051122172027.GA11219@dreamland.darkstar.lan> <20051122214443.GA781@frodo> <20051128002350.GC841@frodo> <20051129162106.GA5002@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051129162106.GA5002@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Tue, Nov 29, 2005 at 05:21:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 05:21:06PM +0100, Luca wrote:
> 
> Great, I'll give it a try ASAP. BTW why using a macro instead of an
> inline function makes any difference? I don't understand...
> 

The initial conversion from macro ->inline was subtely broken
(macro changed the value of a parameter, not picked up in the
conversion), so we reverted that change for now.

cheers.

-- 
Nathan
