Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317663AbSGUI1v>; Sun, 21 Jul 2002 04:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317664AbSGUI1v>; Sun, 21 Jul 2002 04:27:51 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:47541 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317663AbSGUI1u> convert rfc822-to-8bit; Sun, 21 Jul 2002 04:27:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Date: Sun, 21 Jul 2002 10:33:59 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <p731y9xva8m.fsf@oldwotan.suse.de>
In-Reply-To: <p731y9xva8m.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207211033.59266.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 21. Juli 2002 08:57 schrieb Andi Kleen:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > o EVMS (Enterprise Volume Management System)      (EVMS team)
> >
> > or LVM2, which already appears to be scrubbed down and clean
>
> Is there any reason why not both can go in? As far as I know neither
> of them needs much of core changes, they are more like independent
> "drivers" of the generic block layer stacking interface. There are
> already multiple drivers of this - LVM and the various MD personalities.

The interfaces to filesystems for things like online resizing.
If these are not compatible and stay compatible, you cause fs
developers a lot of pain.

	Regards
		Oliver

