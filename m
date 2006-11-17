Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755988AbWKQWoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbWKQWoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbWKQWoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:44:20 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:21135 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1755988AbWKQWoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:44:19 -0500
Date: Fri, 17 Nov 2006 17:44:03 -0500
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
Message-ID: <20061117224403.GE8238@csclub.uwaterloo.ca>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com> <20061116223721.GS8236@csclub.uwaterloo.ca> <455DBC88.6040701@s5r6.in-berlin.de> <20061117142928.GT8236@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117142928.GT8236@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:29:28AM -0500, Lennart Sorensen wrote:
> Wow, that looks really neat.  I will have to go read up on that tool.

OK, I have now tried connecting with firescope to just follow the dmesg
buffer across firewire.  Works great, until the system hangs, then
firescope reports that it couldn't perform the read.  I wonder what part
of the system has to lock up for the firewire card to no longer be able
to read memory on the system.

--
Len Sorensen
