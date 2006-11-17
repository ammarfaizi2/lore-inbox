Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753456AbWKQXKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWKQXKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbWKQXKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:10:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53652 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1753456AbWKQXKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:10:04 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455E4142.8090202@s5r6.in-berlin.de>
Date: Sat, 18 Nov 2006 00:09:54 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com> <20061116223721.GS8236@csclub.uwaterloo.ca> <455DBC88.6040701@s5r6.in-berlin.de> <20061117142928.GT8236@csclub.uwaterloo.ca> <20061117224403.GE8238@csclub.uwaterloo.ca>
In-Reply-To: <20061117224403.GE8238@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> OK, I have now tried connecting with firescope to just follow the dmesg
> buffer across firewire.  Works great, until the system hangs, then
> firescope reports that it couldn't perform the read.  I wonder what part
> of the system has to lock up for the firewire card to no longer be able
> to read memory on the system.

I suppose the PCI bus is no longer accessible to the chip.
-- 
Stefan Richter
-=====-=-==- =-== =--=-
http://arcgraph.de/sr/
