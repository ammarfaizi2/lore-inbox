Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFIVc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTFIVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:32:08 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8644 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262123AbTFIVaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:30:46 -0400
Date: Mon, 9 Jun 2003 14:40:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm6
Message-Id: <20030609144035.347c2987.akpm@digeo.com>
In-Reply-To: <20030609232001.3980cb7a.diegocg@teleline.es>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
	<20030609232001.3980cb7a.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 09 Jun 2003 21:44:25.0617 (UTC) FILETIME=[4BCAE810:01C32ED0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García <diegocg@teleline.es> wrote:
>
> On Mon, 9 Jun 2003 19:45:58 +0200 (CEST)
> Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
> 
> > The interactivity seems to have dropped. Again, with common desktop
> > applications: xmms playing with ALSA, when choosing navigating through
> > evolution options or browsing with opera, music skipps.
> > X is running with nice -10, but with mm5 it ran smoothly.
> 
> Under "heavy" disk usage (when sylpheed finish merging the lkml
> messages in the 92M lkml mail folder) X pointer stops moving 
> (say, 1/8 or 1/6 seconds, very noticeable, pointer stops, windows stop
> redrawing, etc).

I've noticed similar.  Just a new vague jerkiness.

> System is a dual p3 800; fs is ext3. This odd behaviour
> seems to happen since the 2.5.69-mm9 ext3 locking changes.
> (well i started testing 2.5.70-mm3 because i'm timid,
> but never happened before in mm or mainline)

Might be.  There were some CPU scheduler changes a week before 2.5.69-mm9. 
If it's in ext3 then profiling will probably shake it out.  I haven't done
a lot of profiling yet.

