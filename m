Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293255AbSBWXIf>; Sat, 23 Feb 2002 18:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293254AbSBWXI0>; Sat, 23 Feb 2002 18:08:26 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:26845 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S293255AbSBWXIJ>;
	Sat, 23 Feb 2002 18:08:09 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <200202231011.g1NABaU10984@devserv.devel.redhat.com> <25097.1014467212@ocs3.intra.ocs.com.au> <20020223075002.A23666@devserv.devel.redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 24 Feb 2002 00:07:13 +0100
In-Reply-To: Pete Zaitcev's message of "Sat, 23 Feb 2002 07:50:02 -0500"
Message-ID: <d3n0xzre5a.fsf@lxplus049.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> Personally, I have no problem handling current practices.
> But I may see the point of the guy with the try/catch patch.
> Do not make me to defend him though. I am trying to learn
> is those exceptions are actually helpful. BTW, we all know
> where they come from (all of Cutler's NT is written that way),
> but let it not cloud our judgement.

The problem here is that when using exceptions, you stop thinking
about what is going on underneath at the low level which is really not
what one wants in the kernel.

After all, C is just and advanced assembly interface, which is exactly
why it's such a great language ;-)

Jes
