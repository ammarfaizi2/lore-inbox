Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSLMJ5d>; Fri, 13 Dec 2002 04:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSLMJ5c>; Fri, 13 Dec 2002 04:57:32 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:38088
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261842AbSLMJ5c>; Fri, 13 Dec 2002 04:57:32 -0500
Subject: Re: 2.5.51 ide module problem (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Chua <jchua@fedex.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de,
       linux-ide@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20021213013637.4F2652C0ED@lists.samba.org>
References: <20021213013637.4F2652C0ED@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 10:42:46 +0000
Message-Id: <1039776166.25121.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 01:35, Rusty Russell wrote:
> Also, my stress_modules script gave the following warning then oops
> from ide-cd on 2.5.51 SMP x86 (IDE is built-in):

Yes. This mysteriously stsrted happening. I don't know if its now
trapping a long standing IDE bug or its of the other changes people did
to IDE to make it actually follow the devices model properly. I've got a
slightly similar looking 2.4 bug to chase down which makes me suspect
the former.

