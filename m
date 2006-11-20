Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966447AbWKTTOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966447AbWKTTOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966448AbWKTTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:14:38 -0500
Received: from bay0-omc2-s14.bay0.hotmail.com ([65.54.246.150]:47701 "EHLO
	bay0-omc2-s14.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S966447AbWKTTOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:14:37 -0500
Message-ID: <BAY107-F203123A8A58AB4F1F8E38AABED0@phx.gbl>
X-Originating-IP: [69.145.86.254]
X-Originating-Email: [eyubo@hotmail.com]
In-Reply-To: <1164009958.31358.564.camel@laptopd505.fenrus.org>
From: "e m" <eyubo@hotmail.com>
To: arjan@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: path_lookup for executable
Date: Mon, 20 Nov 2006 19:14:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 20 Nov 2006 19:14:36.0534 (UTC) FILETIME=[1E5EB160:01C70CD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for response. Is there any other way to identify if "current"  is a 
certain program  such as java.  You cannot surely go by name (comm field of 
task_struct). Since  It could be linked. In another word, I want to identify 
the executing current program. Any help appreciated.

Thanks,
Eyub


>From: Arjan van de Ven <arjan@infradead.org>
>To: e m <eyubo@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: path_lookup for executable
>Date: Mon, 20 Nov 2006 09:05:57 +0100
>
>On Mon, 2006-11-20 at 04:00 +0000, e m wrote:
> > I am trying to get inode for an executable program. For example, I wish 
>to
> > get inode for /usr/jdk/bin/java file in a module. The following call 
>always
> > return an error. Is there a way to get the inode of current process,
> > assuming I have access to "current"
>
>
>Hi,
>
>what makes you think the current executable has any meaning? It can be
>unlinked, renamed or moved in the directory hierarchy since the program
>was started... (and if you would go by inode number.. then there's
>multiple answers possible)
>
>

_________________________________________________________________
Share your latest news with your friends with the Windows Live Spaces 
friends module. 
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mk

