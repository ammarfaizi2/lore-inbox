Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTEINeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTEINeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:34:22 -0400
Received: from mail.ithnet.com ([217.64.64.8]:25352 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263258AbTEINeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:34:21 -0400
Date: Fri, 9 May 2003 15:46:37 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030509154637.5cf14c8d.skraw@ithnet.com>
In-Reply-To: <20030509132757.GA16649@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030509132757.GA16649@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003 15:27:57 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> On Fri, May 09, 2003 at 03:02:07PM +0200, Stephan von Krawczynski wrote:
>  
> > I cannot say which version of the driver it was, the only thing I can tell
> > you is that the archive was called aic79xx-linux-2.4-20030410-tar.gz.
> 
> That's really interesting, because I got the bug since around this version
> (20030417 IIRC), and it locked up only on SMP, sometimes during boot, or
> during heavy disk accesses caused by "updatedb" and "make -j dep". It's
> fixed in 20030502 from http://people.freebsd.org/~gibbs/linux/SRC/

I tried to merge the latest aic archive into 2.4.21-rc2, besides the "usual"
signed/unsigned warnings I got this one:

aic7xxx_osm.c: In function `ahc_linux_map_seg':
aic7xxx_osm.c:770: warning: integer constant is too large for "long" type

FYI

-- 
Regards,
Stephan
