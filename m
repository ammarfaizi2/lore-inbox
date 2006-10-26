Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423616AbWJZQlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423616AbWJZQlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423615AbWJZQlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:41:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20174 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423616AbWJZQlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:41:09 -0400
Message-ID: <4540E500.9080701@zytor.com>
Date: Thu, 26 Oct 2006 09:40:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [git failure] failure pulling latest Linus tree
References: <yq0d58g92u0.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org> <453F8630.2000608@zytor.com> <72AE9332-F318-4853-8DC9-B6BC7FD1E055@kernel.crashing.org>
In-Reply-To: <72AE9332-F318-4853-8DC9-B6BC7FD1E055@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> 
> It the issue suppose to be fixed, I'm still seeing the same behavior 
> where one server seems ok and the other does:
> 
> [galak@blarg tmp]$ git clone 
> git://git.kernel.org/pub/scm/boot/u-boot/galak/u-boot.git
> fatal: read error (Connection reset by peer)
> fetch-pack from 
> 'git://git.kernel.org/pub/scm/boot/u-boot/galak/u-boot.git' failed.
> 

No, this is due to the load on the servers being very high at the 
moment.  The only thing that can help that is a dedicated git server, 
which we currently don't have equipment for.

	-hpa
