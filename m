Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTDQXlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbTDQXlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:41:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64693 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262680AbTDQXlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:41:04 -0400
Message-ID: <3E9F3E51.5070008@pobox.com>
Date: Thu, 17 Apr 2003 19:52:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
References: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com> <3E9F3D6F.9030501@pobox.com>
In-Reply-To: <3E9F3D6F.9030501@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> If DTRT means not using MMX/SSE[2], that's a given considering the above 
> code is from the "we don't have MMX/SSE" part of the ifdef.  If gcc 
> starts using MMX with -march=i586 it's time for us all to go home and 
> write a new compiler ;-)


nevermind on this point, it's obviously not -march=<old>.

	Jeff



