Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUGGSJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUGGSJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUGGSJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:09:17 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:62344 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265266AbUGGSJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:09:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.7-mm6
Date: Wed, 7 Jul 2004 12:15:52 -0500
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407070015.39507.dtor_core@ameritech.net> <20040707163103.GA1368@ucw.cz>
In-Reply-To: <20040707163103.GA1368@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407071215.53350.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 July 2004 11:31 am, Vojtech Pavlik wrote:
> On Wed, Jul 07, 2004 at 12:15:37AM -0500, Dmitry Torokhov wrote:
> > The only suspicious thing that I see is that sunzilog tries to register its
> > serio ports with spinlock held and interrupts off. I wonder if that is what
> > causing a deadlock. Could you please try applying this patch on top of the
> > changes to the drivers/Makefile that I sent earlier.
> 
> Shall I add this to my BK then?
> 

I was planning on pushing some updates to you later tonight, but if you want
you can just apply that patch. The change to Makefile is also needed.

-- 
Dmitry
