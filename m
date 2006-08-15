Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWHOGL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWHOGL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWHOGL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:11:57 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:6324 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965108AbWHOGL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:11:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=GH+Z+TI7gc+VvATBorjSwCCR6295G4Pcj0BXn9uForD5X4VCPsTxLmvPkRp1qe9VwuRcfk2pLvpx1a4wPLJhQ56ijowlbnpU+5nNoINgBmqp7PzpiuB0uDlC7ELPishBUp7Ld8s2uMF23KD1jIAumoclzcr5vGTbnbHuphO7N24=
Subject: Re: vga text console
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: James C Georgas <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155607768.8131.22.camel@Rainsong>
References: <1155604313.8131.4.camel@Rainsong>
	 <1155604928.3948.8.camel@daplas.org>  <1155605197.3948.10.camel@daplas.org>
	 <1155606109.8131.13.camel@Rainsong>  <1155606849.3948.17.camel@daplas.org>
	 <1155607768.8131.22.camel@Rainsong>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 14:11:50 +0800
Message-Id: <1155622311.3854.1.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 22:09 -0400, James C Georgas wrote:
> On Tue, 2006-15-08 at 09:54 +0800, Antonino A. Daplas wrote:
> > > If I define CONFIG_EMBEDDED, is that going to change the behaviour of
> > > other subsystems, or does it just enable more options?
> > > 
> > 
> > It basically opens up a lot of config options. It may also disable a few
> > incompatible options (ie, CONFIG_DEBUG_VERBOSE), and enable a few.  It
> > will require that you know exactly what options need to be turned on or
> > off.
> Oh. That actually sounds like it could be a lot of fun. I'm a big fan of
> the Minimal Kernel.
> 
> I'm kind of surprised that the VGA console can't be built as a module,
> like the other console drivers in the kernel can be. Is this on purpose,
> or is it just that nobody has gotten around to it?
> 

It's possible to make vgacon modular, the changes required will be
minimal. It would seem that nobody ever had a need for it, so that was
never done.

Tony

