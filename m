Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbUKQWko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUKQWko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUKQWid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:38:33 -0500
Received: from smtp-out.hotpop.com ([38.113.3.51]:20119 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262596AbUKQWhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:37:53 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Date: Thu, 18 Nov 2004 06:35:32 +0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411180635.32907.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Philipp Matthias Hahn <pmhahn@titan.lahn.de> wrote:

> Hello!
> 
> On Wed, Nov 17, 2004 at 05:20:58AM +0800, Antonino
> A. Daplas wrote:
> > -		               FBINFO_HWACCEL_XPAN;
> > +		               FBINFO_HWACCEL_XPAN |
> > +	                      
> FBINFO_MISC_MODESWITCHLATE;
> 
> That (partly) solved the lockup: I was able start
> XFree86, switch back
> to Console, but on return to X11, the X11 screen
> wasn't restored
> correctly, the mouse left a trail behind and
> switching to console

Try Option "UseBios" "False" in your /etc/X11/XF86Config, if at all possible.

Tony


