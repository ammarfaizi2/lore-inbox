Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVLFSBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVLFSBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVLFSB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:01:29 -0500
Received: from ns1.suse.de ([195.135.220.2]:37524 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964974AbVLFSB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:27 -0500
Date: Tue, 6 Dec 2005 19:01:26 +0100
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>,
       David Engraf <engraf.david@netcom-sicherheitstechnik.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Message-ID: <20051206180126.GP11190@wotan.suse.de>
References: <1133871202.3664.34.camel@tara.firmix.at> <000201c5fa60$52bb53e0$0a016696@EW10> <p73psoaqa5u.fsf@verdi.suse.de> <4395D1C2.2040909@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395D1C2.2040909@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 07:00:34PM +0100, Eric Dumazet wrote:
> Andi Kleen a ?crit :
> >"David Engraf" <engraf.david@netcom-sicherheitstechnik.de> writes:
> >
> >>times has only 10ms resolution, we need at least 1ms.
> >
> >
> >It actually has jiffies resultion. Your measurements must have been
> >quite off.
> 
> I beg to differ: times has a 10 ms resolution ( ie 1/USER_HZ)

You're right. Sorry for the confusion. clock_gettime is the way
to go.

-Andi
