Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTFXXx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFXXx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:53:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263179AbTFXXxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:53:25 -0400
Message-ID: <3EF8E7B0.4030700@zytor.com>
Date: Tue, 24 Jun 2003 17:07:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: jlnance@unity.ncsu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.72: follow_mount / follow_link
References: <3EF86337.1020103@sun.com> <20030624145418.GP6754@parcelfarce.linux.theplanet.co.uk> <bd9ri0$fn2$1@cesium.transmeta.com> <20030624235049.GA9292@ncsu.edu>
In-Reply-To: <20030624235049.GA9292@ncsu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
> On Tue, Jun 24, 2003 at 08:42:56AM -0700, H. Peter Anvin wrote:
> 
> 
>>Unfortunately, this is probably the only realistic way to ever get
>>working direct mounts, so please don't dismiss it out of hand.
>>follow_link on a directory has turned out to be a really useful way of
>>doing automounting.
> 
> 
> Hi Peter,
>     I have always wondered why direct mounts, as well as things like
> /net/host are difficult with Linux.  If you have a couple of minutes,
> would you explain the problem?  Also, do you have any idea how Solaris
> does this and is it easier there?
> 

Oh yes... no, I don't know what Solaris does, although I suspect they
had to adjust their VFS to *make* it work (management directive: this
shalt work) even if that meant overall performance loss.

If you don't find something in the autofs archives get back to me or
corner me on IRC sometime.

	-hpa


