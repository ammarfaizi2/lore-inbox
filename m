Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318381AbSGRWTj>; Thu, 18 Jul 2002 18:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318382AbSGRWTj>; Thu, 18 Jul 2002 18:19:39 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:13197 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S318381AbSGRWTh>; Thu, 18 Jul 2002 18:19:37 -0400
Date: Fri, 19 Jul 2002 01:17:17 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Sun <asun@cobaltnet.com>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: Generic modules documentation is outdated
Message-ID: <20020718231717.GA8165@bylbo.nowhere.earth>
References: <20020704212240.GB659@bylbo.nowhere.earth> <20020718210259.GJ19580@bylbo.nowhere.earth> <1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:48:41PM +0100, Alan Cox wrote:
> On Thu, 2002-07-18 at 22:02, Yann Dirson wrote:
> > - I have installed no proprietary driver, all loaded drivers declare to be
> > "GPL" or "Dual BSD/GPL". 
> 
> Something you loaded was missing a MODULE_LICENSE tag - modern insmod
> will warn on this one

OK.  I found a good candidate in the Apple HFS module.  Although I only have
it compiled "just in case" and don't use it, possibly some
filesystem-probing stuff has it loaded.

Unfortunately, the fact that it is insmod telling this results in no
messages in the logs...

Adrian: you're listed as HFS maintainer - could you please take care of
adding that module information ?  (my appologies if it's done in 2.4.19rc)

Regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
