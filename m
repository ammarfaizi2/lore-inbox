Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbTFXENs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbTFXENr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:13:47 -0400
Received: from terminus.zytor.com ([63.209.29.3]:16850 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265655AbTFXENr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:13:47 -0400
Message-ID: <3EF7D33E.6060009@zytor.com>
Date: Mon, 23 Jun 2003 21:27:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel & BIOS return differing head/sector geometries
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl> <bd8hgj$cas$1@cesium.transmeta.com> <20030624012220.E1418@almesberger.net>
In-Reply-To: <20030624012220.E1418@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> H. Peter Anvin wrote:
> 
>>Actually, unless you have it "linear" or "lba32", LILO *does* use
>>CHS.  Unfortunately.
> 
> 
> Distribution makers shouldn't be overly impressed by this default,
> and just put "lba32" into any new lilo.conf they generate, or at
> least offer the option to do so.
> 
> Keeping the old CHS default makes sure that people upgrading LILO
> on an already configured (and probably quite ancient) system that
> really needs CHS don't get a nasty surprise.
> 

Presumably "linear", not "lba32".  I *presume* LILO has enough 
wherewithal to use EBIOS if it's available and fall back to CBIOS 
otherwise for at least one of these options.  I at least thought "lba32" 
would force EBIOS usage.

	-hpa


