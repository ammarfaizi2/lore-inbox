Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWCWSMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWCWSMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCWSMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:12:07 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:7000 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422639AbWCWSMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:12:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j7c/jKn9B1XCzkwK7cDQTA1rhsgXP6jYIYBxig2DGLJBv4YxRkFTBRmtedwtdKSdv+bUid2m4Rn8DXMmrwK21pRv8+a+RluRn2fx05wqubqQVfGNuJSKiQ8VTrKkoApde3cqBaCIwCqzQv8oRtPS+iXHfh7HnZ5X9YFwyFeLDeA=
Message-ID: <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>
Date: Thu, 23 Mar 2006 13:12:05 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Stas Sergeev" <stsp@aknet.ru>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <4422E2DA.7050305@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>
	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>
	 <4422318C.407@aknet.ru>
	 <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>
	 <4422E2DA.7050305@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Stas Sergeev <stsp@aknet.ru> wrote:
>
> > Because
> > next time you want to disable for example a framebuffer driver because
> > you have written better one and you are back to square 1.
> The difference is that the snd-pcsp and pcspkr drivers are doing the
> completely different tasks. snd-pcsp doesn't absolete pcspkr - being
> an ALSA driver it only plays sound, but doesn't do the console beeps,
> thats the problem. Somehow I have to make sure they both can peacefully
> co-exist. Making them mutually exclusive is bad, and making them
> dependant (by calling into each other directly) is also rather bad.
>

OK, you need to tell me again what snd_pcsp and what exactly it
functions are, because I am confised at the moment. If it is just for
playing sounds/music through PC speaker then I don't understand why
you want to disable pcspkr driver - if people don't like terminal
beeps they can disable it.

--
Dmitry
