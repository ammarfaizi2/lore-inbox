Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTFIVN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTFIVN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:13:56 -0400
Received: from smtp.terra.es ([213.4.129.129]:64659 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S262037AbTFIVNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:13:55 -0400
Date: Mon, 9 Jun 2003 23:20:01 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm6
Message-Id: <20030609232001.3980cb7a.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003 19:45:58 +0200 (CEST)
Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

> The interactivity seems to have dropped. Again, with common desktop
> applications: xmms playing with ALSA, when choosing navigating through
> evolution options or browsing with opera, music skipps.
> X is running with nice -10, but with mm5 it ran smoothly.

Under "heavy" disk usage (when sylpheed finish merging the lkml
messages in the 92M lkml mail folder) X pointer stops moving 
(say, 1/8 or 1/6 seconds, very noticeable, pointer stops, windows stop
redrawing, etc).

System is a dual p3 800; fs is ext3. This odd behaviour
seems to happen since the 2.5.69-mm9 ext3 locking changes.
(well i started testing 2.5.70-mm3 because i'm timid,
but never happened before in mm or mainline)

Sorry that i can't provide really useful information now ;(
