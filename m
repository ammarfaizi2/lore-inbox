Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTGCKnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTGCKnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:43:55 -0400
Received: from mail.ithnet.com ([217.64.64.8]:2570 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264256AbTGCKny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:43:54 -0400
Date: Thu, 3 Jul 2003 12:58:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, andrea@suse.de, piggin@cyberone.com.au
Subject: Re: Status of the IO scheduler fixes for 2.4
Message-Id: <20030703125828.1347879d.skraw@ithnet.com>
In-Reply-To: <1057197726.20903.1011.camel@tiny.suse.com>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	<Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
	<1057197726.20903.1011.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Jul 2003 22:02:07 -0400
Chris Mason <mason@suse.com> wrote:

> [...]
> Nick would like to see a better balance of throughput/fairness, I wimped
> out and went for the userspace toggle instead because I think anything
> else requires pulling in larger changes from 2.5 land.

I have a short question on that: did you check if there are any drawbacks on
network performance through this? We had a phenomenon here with 2.4.21 with
both samba and simple ftp where network performance dropped to a crawl when
simply entering "sync" on the console. Even simple telnet-sessions seemed to be
affected. As we could not create a reproducable setup I did not talk about this
up to now, but I wonder if anyone else ever checked that out ...

Regards,
Stephan


