Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275592AbTHMVPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275593AbTHMVPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:15:37 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:2727
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275592AbTHMVPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:15:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>, Voluspa <lista1@telia.com>
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Date: Thu, 14 Aug 2003 07:21:26 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030812172358.5afe0cc1.lista1@telia.com> <20030813025428.3569ffbc.lista1@telia.com> <3F3A8766.9050909@techsource.com>
In-Reply-To: <3F3A8766.9050909@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308140721.26351.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 04:45, Timothy Miller wrote:
> Voluspa wrote:
> > When the blackout starts I no longer have to move the mouse, it is
> > enough to hold down the button. The second I release it, the music
> > returns.
>
> I think this sort of thing has been discussed before.  I get the
> impression that xmms blocks on the X server, so when some app grabs the
> server, then xmms gets blocked and stops.  I don't know why the display
> code is not in a separate thread from the audio code; although maybe
> they are but they interact somehow that causes this.

This is a pure sheduler starvation issue which I'm trying to fix.

Con

