Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbTLBUxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTLBUxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:53:41 -0500
Received: from mx1.verat.net ([217.26.64.139]:43725 "EHLO mx1.verat.net")
	by vger.kernel.org with ESMTP id S264345AbTLBUxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:53:37 -0500
From: snpe <snpe@snpe.co.yu>
To: Wilmer van der Gaast <lintux@lintux.cx>, Patrick McHardy <kaber@trash.net>
Subject: Re: 2.4.23 masquerading broken?
Date: Tue, 2 Dec 2003 20:18:03 +0000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
References: <20031202165653.GJ615@gaast.net> <3FCCCB02.5070203@trash.net> <20031202173358.GK615@gaast.net>
In-Reply-To: <20031202173358.GK615@gaast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312022018.03078.snpe@snpe.co.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It work for me
(2.4.23 with linux abi, gcc 3.2 from RedHat 8.0 - netfilter like modules)
regards
Haris Peco
On Tuesday 02 December 2003 05:33 pm, Wilmer van der Gaast wrote:
> Patrick McHardy (kaber@trash.net) wrote:
> > Can you check the ringbuffer for error messages ? What happens
> > to the packets when masquerading fails ?
>
> Hmm. Damn, forgot about the syslogs completely. :-(
>
> Dec  2 16:42:30 tosca kernel: MASQUERADE: Route sent us somewhere else.
> Dec  2 16:42:44 tosca last message repeated 11 times
> Dec  2 16:42:47 tosca kernel: NET: 1 messages suppressed.
> Dec  2 16:42:47 tosca kernel: MASQUERADE: Route sent us somewhere else.
> Dec  2 16:42:51 tosca kernel: NET: 5 messages suppressed.
> Dec  2 16:42:51 tosca kernel: MASQUERADE: Route sent us somewhere else.
> Dec  2 16:42:57 tosca kernel: NET: 4 messages suppressed.
> Dec  2 16:42:57 tosca kernel: MASQUERADE: Route sent us somewhere else.
>
> And, well, it goes on like that. dmesg is full of messages like this.
>
> The packages seem to get lost completely. At least I don't see them
> going out on eth1 (where they should go to).
>
>
> Wilmer van der Gaast.

