Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273692AbRIWXzN>; Sun, 23 Sep 2001 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273701AbRIWXzD>; Sun, 23 Sep 2001 19:55:03 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:7370 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S273692AbRIWXyt>; Sun, 23 Sep 2001 19:54:49 -0400
Date: Sun, 23 Sep 2001 19:55:00 -0400
From: Chris Mason <mason@suse.com>
To: Wolly <wwolly@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Huge disk performance degradation STILL IN 2.4.10
Message-ID: <2100580000.1001289300@tiny>
In-Reply-To: <200109232319.BAA02449@enigma.deepspace.net>
In-Reply-To: <200109211723.TAA00638@enigma.deepspace.net>
 <200109232319.BAA02449@enigma.deepspace.net>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 24, 2001 01:19:18 AM +0200 Wolly <wwolly@gmx.net>
wrote:

> Hi kernel hackers, 
> 
> As soon as 2.4.10 was out, I got the patch and tested it again. 
> The problem is still there and did not get better at all. 
> 

Could you please mount the FS with -o notail and try again?  I think your
test is hitting a worst case in the 2.4.x reiserfs tail code.

-chris


