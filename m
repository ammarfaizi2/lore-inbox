Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSDNNLf>; Sun, 14 Apr 2002 09:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312277AbSDNNLe>; Sun, 14 Apr 2002 09:11:34 -0400
Received: from h00403399c977.ne.client2.attbi.com ([24.218.54.41]:48026 "EHLO
	fred.cambridge.ma.us") by vger.kernel.org with ESMTP
	id <S312269AbSDNNLd>; Sun, 14 Apr 2002 09:11:33 -0400
From: pjd@fred001.dynip.com
Message-Id: <200204141311.g3EDBUP22922@fred.cambridge.ma.us>
Subject: Re: module programming smp-safety howto?
To: emmanuel_michon@realmagic.fr (Emmanuel Michon)
Date: Sun, 14 Apr 2002 09:11:30 -0400 (EDT)
Cc: aia21@cus.cam.ac.uk (Anton Altaparmakov),
        emmanuel_michon@realmagic.fr (Emmanuel Michon),
        linux-kernel@vger.kernel.org
In-Reply-To: <7whemjbj48.fsf@avalon.france.sdesigns.com> from "Emmanuel Michon" at Apr 10, 2002 06:42:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Michon wrote:
> 
> Anton Altaparmakov <aia21@cus.cam.ac.uk> writes:
> 
> > Also, are we going to see the driver published under GPL (I sure hope
> > so!) or is it going to be binary only as per usual Sigma Designs policy?
> 
> The core library (supporting the PCI chip and all devices attached
> thru its i2c) is binary only.

If it's anything like the code that Sigma has for its 8400/8401, I
would keep it private out of sheer embarrassment, myself.

It sounds like you're doing from-the-ground-up new development, instead
of trying to port the user-space library for the 8400, which is a 
good thing, as the 8400 code we licensed under NDA at my last position
was a steaming pile of dung.  It also sounds like you're making a real
driver, instead of a shim driver that mmaps all the hardware for a
user-space library - another good design decision.

 Peter Desnoyers 
