Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWHRCEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWHRCEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWHRCEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 22:04:05 -0400
Received: from relay03.pair.com ([209.68.5.17]:13577 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932256AbWHRCEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 22:04:04 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: GPL Violation?
Date: Thu, 17 Aug 2006 21:03:36 -0500
User-Agent: KMail/1.9.4
Cc: Grzegorz Kulewski <kangur@polcom.net>, Adrian Bunk <bunk@stusta.de>,
       Patrick McFarland <diablod3@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <Pine.LNX.4.63.0608171410570.14828@alpha.polcom.net> <1155822112.15195.88.camel@localhost.localdomain>
In-Reply-To: <1155822112.15195.88.camel@localhost.localdomain>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608172103.59498.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 08:41, Alan Cox wrote:
> Ar Iau, 2006-08-17 am 14:39 +0200, ysgrifennodd Grzegorz Kulewski:
> > Why does Linus and others let lawyers and courts decide in such
> > (important?) thing like what is allowed in Linux (or with Linux) and what
> > is not?
>
> Because licenses are bounded and defined by the law. In the case of
> copyright based rights they extend only to the thing that is copyrighted
> and any derivatives so the grey area is not one the GPL could clarify
> further.
>

IANAL, but I think there are 2 cases here:

1. The courts decide what "derived works" are when someone distributes code 
that they wrote. So if NVIDIA writes nvidia.ko, the courts will decide if 
nvidia.ko is a derived work.

2. However, the only valid license under which to distribute the Linux kernel 
is GPL. If the GPL prohibits linking in non-GPL code, and Linux adds no 
exception, then one clearly has no license to distribute Linux if they 
distribute it alongside code that links in to Linux and does not carry the 
GPL license. If they were just shipping binary modules, it's questionable 
grey area. But if they distribute _Linux itself_, especially considering they 
haven't paid for it (and hence have no 'natural' rights), they must comply 
with the GPL and the GPL's definitions of its terms, else they have no 
license at all to distribute Linux and are in violation of copyright.

NVIDIA might be able to skate closer to the cracks because they do not 
distribute the Linux kernel. NVIDIA couldn't ship NVIDIA Linux with the 
binary-only driver. TiVo has to obey the GPL to distribute Linux, so does 
Linksys, etc. In the embedded case, you're distributing the kernel which 
means you must execute whatever conditions GPL chooses to impose.

Thanks,
Chase
