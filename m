Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273031AbTHKR7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272983AbTHKR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:59:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27372 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272943AbTHKR4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:56:35 -0400
Message-ID: <3F37D8C7.5050906@pobox.com>
Date: Mon, 11 Aug 2003 13:56:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove useless assertions from reiserfs
References: <E19mFqr-00068B-00@tetrachloride> <3F37D63A.8010500@pobox.com> <20030811175237.GA1402@redhat.com>
In-Reply-To: <20030811175237.GA1402@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Aug 11, 2003 at 01:45:30PM -0400, Jeff Garzik wrote:
>  > Why are these useless?
> 
> read the code not the diff.
> 
>  > >@@ -90,10 +90,6 @@ u32 keyed_hash(const signed char *msg, i
>  > > 
>  > > 	if (len >= 12)
>  > > 	{
>  > >-	    	//assert(len < 16);
>  > >-		if (len >= 16)
>  > >-		    BUG();
>  > >-
>  > > 		a = (u32)msg[ 0]      |
>  > > 		    (u32)msg[ 1] << 8 |
>  > > 		    (u32)msg[ 2] << 16|
>  > 
>  > Seems like a valid check to me...
> 
> Above this loop is another loop which we don't exit until len < 16

ok, agreed

	Jeff




