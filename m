Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293658AbSCESLe>; Tue, 5 Mar 2002 13:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293653AbSCESLP>; Tue, 5 Mar 2002 13:11:15 -0500
Received: from mnh-1-09.mv.com ([207.22.10.41]:38662 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293654AbSCESLM>;
	Tue, 5 Mar 2002 13:11:12 -0500
Message-Id: <200203051812.NAA03363@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Tue, 05 Mar 2002 08:37:29 PST."
             <3C84F449.8090404@zytor.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Mar 2002 13:12:19 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com said:
> Actually, yes, esp. since the only case you have been able to bring up
> is  one of the sysadmin being a moron. 

Really?  And you're unconcerned about the impact on the rest of the system
of a UML grabbing (say) 128M of memory when it starts up?  Especially if it
may never use it?

And I don't see anything wrong with starting a bunch of UMLs with a total
maximum memory exceeding the available tmpfs as long as they don't all need
all that memory at once.  And, if they do, the patch I just posted will let
them deal fairly sanely with the situation.

				Jeff

