Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWC0SkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWC0SkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWC0SkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:40:04 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:47509 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750774AbWC0SkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:40:01 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: bug in 2.6.16-mm1 - snd-ad1816a is not being loaded
Date: Mon, 27 Mar 2006 11:39:54 -0700
User-Agent: KMail/1.8.3
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Thorsten Knabe <linux@thorsten-knabe.de>, Takashi Iwai <tiwai@suse.de>
References: <19226.1143210977@www043.gmx.net>
In-Reply-To: <19226.1143210977@www043.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603271139.54617.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 07:36, Uwe Bugla wrote:
> Hi folks,
> I've tried Bjorn Hellgaas' patch which is included in 2.6.16-mm1. Thanks for
> his attempts. But the problem still persists:
> snd-ad1816a still refuses to load and dmesg still talks about a PnP
> configuration error. If you need additional information, please tell me how
> to produce it. 2.6.16 without mm1 works fine so far.
> 
> Ciao
> Uwe
> P. S.: In the first lines of dmesg the card is being recognized and the card
> ID is being printed out to the console. But as soon as it goes to loading
> the driver module the whole thing is broken and the module is not being
> loaded, while dmesg prints out a PnP configuration error.

For anybody else interested, I opened a kernel bugzilla for this,
and Uwe provided complete dmesg logs, which I attached there:

    http://bugzilla.kernel.org/show_bug.cgi?id=6292
