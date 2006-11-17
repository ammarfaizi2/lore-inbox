Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932889AbWKQO3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWKQO3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933617AbWKQO3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:29:40 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:63943 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932889AbWKQO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:29:39 -0500
Date: Fri, 17 Nov 2006 09:29:28 -0500
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
Message-ID: <20061117142928.GT8236@csclub.uwaterloo.ca>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com> <20061116223721.GS8236@csclub.uwaterloo.ca> <455DBC88.6040701@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DBC88.6040701@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 02:43:36PM +0100, Stefan Richter wrote:
> If the PCI bus itself isn't brought down, you could debug from remote
> using Benjamin Herrenschmidt's Firescope on the remote node and a
> FireWire card in the test machine. Once the ohci1394 driver was loaded,
> the FireWire controller is able to read and write to the 32bit PCI
> address range (and thus to system memory) without assistance of
> interrupt handlers.

Wow, that looks really neat.  I will have to go read up on that tool.

--
Len Sorensen
