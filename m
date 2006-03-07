Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWCGMcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWCGMcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbWCGMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:32:22 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:56782 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751704AbWCGMcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:32:22 -0500
From: Duncan Sands <baldrick@free.fr>
To: Jiri Tyr <jiri.tyr@cern.ch>
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
Date: Tue, 7 Mar 2006 13:32:19 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Michel Bardiaux <mbardiaux@mediaxim.be>
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr> <440D7384.5030307@cern.ch>
In-Reply-To: <440D7384.5030307@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071332.19614.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 7 March 2006 12:50, Jiri Tyr wrote:
> Michel Bardiaux wrote:
> 
>  >I dont see anything suspicious conflict. But 'overlay' has been
>  >mentionned, I'm not familiar with that but I assume it means you're
>  >doing video grabs directly to the X display, right?
> 
> Yes, I'm using xawtv + overlay directly to the X display :0.0. Is better 
> way to use it with some WM (KDE, Gnome, ...)?
> 
>  >Then it could be a problem with the graphics card or its driver.
> 
> On the mainboard is graphics card Intel 915. I have tryed it with i810 
> (with / without DRI) and vesa driver. I have also tryed PCIE graphics 
> card from ATI. In all of those cases the PC freeze and as well as if is 
> in PCI slot only ONE tuner!
> 
>  >Just my 2 cents, because I am totally unfamiliar with such uses, sounds
>  >like a problem for the MythTV crowd.
> 
> I'm totally lost! I have here 25 PCs (100 tuners) what always freeze ;o(

Try using grabdisplay.  Also, if you hook up a serial console you may see
some helpful output when the pc freezes.

Ciao,

Duncan.
