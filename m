Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbUKXUrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbUKXUrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUKXUrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:47:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33423 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262847AbUKXUqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:46:21 -0500
Date: Wed, 24 Nov 2004 18:21:55 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Message-ID: <20041124172155.GA5061@titan.lahn.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200411180635.32907.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411180635.32907.adaplas@hotpop.com>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML!

On Thu, Nov 18, 2004 at 06:35:32AM +0800, Antonino A. Daplas wrote:
> > On Wed, Nov 17, 2004 at 05:20:58AM +0800, Antonino
> > A. Daplas wrote:
> > > -		               FBINFO_HWACCEL_XPAN;
> > > +		               FBINFO_HWACCEL_XPAN |
> > > +	                       FBINFO_MISC_MODESWITCHLATE;
> >
> > That (partly) solved the lockup: I was able start XFree86, switch
> > back to Console, but on return to X11, the X11 screen wasn't
> > restored correctly, the mouse left a trail behind and switching to
> > console
>
> Try Option "UseBios" "False" in your /etc/X11/XF86Config, if at all possible.

FYI: That solved the problem, now savagefb and XFree86 are both running
fine. Thank you very much for your support.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
