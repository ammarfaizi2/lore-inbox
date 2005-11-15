Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVKOTTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVKOTTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVKOTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:19:53 -0500
Received: from main.gmane.org ([80.91.229.2]:17631 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965007AbVKOTTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:19:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Date: Tue, 15 Nov 2005 20:11:52 +0100
Message-ID: <pan.2005.11.15.19.11.50.359544@free.fr>
References: <6.1.1.1.0.20051114132644.01ec1170@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Mon, 14 Nov 2005 15:53:42 -0500, Robin Getz a écrit :

> Andrew wrote:
> Since you asked - The Blackfin Processor includes the common 4 processor Ps 
> that people request for embedded designs - price, power, performance & 
> penguins.

Could I add that ADI chips may be are cheap, but the implementation for
that could be ugly.

For example for the usb eagle (adsl chip) developped by ADI, they put the
smallest RAM as possible on the board. For that reason the DSP firmware is
swapped on the host computer : the firmware is split in pages and when the
chip wants a new page it asks it via an interrupt and the host sends the
requested page...

Also ADI never cares to correct some bugs in the usb eagle firmware nor to
sent us a correct documentation (after 6 months of discusion, they sent us
a 3 years old documentation and they never agree to put a
license for the firmware).

Finaly most of the linux code from ADI that I saw in my eagle usb projects
and in my job weren't very Linux compliant/robust (the first version of
eagle usb driver made by ADI had a memleack that make the modem unsuable
after some hours of use) [1].

I know there are different teams at Analog device and blackfin guys aren't
related to these projects.

I hope backfin project will change my vision of ADI ;)

Matthieu

[1] we have a joke about that : (in french) Là où ADI passe, les
standards trépassent.

