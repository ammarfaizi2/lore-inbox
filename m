Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTFKULi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTFKULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:11:38 -0400
Received: from mail.ithnet.com ([217.64.64.8]:47369 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263458AbTFKULh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:11:37 -0400
Date: Wed, 11 Jun 2003 22:23:46 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030611222346.0a26729e.skraw@ithnet.com>
In-Reply-To: <41560000.1055306361@caspian.scsiguy.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a short note on todays test cycles.
I switched to rc8 (SMP, apic), took three cycles until it failed.
rc8 (SMP, apic, HIGHIO) failed on the first try.
I thought HIGHIO could make a difference if there were inherent problems with
bounce buffers. Unfortunately this seems not the case.

Anyway it looks like failures have gotten fewer since rc8. I will try an
overnight stress test now to see if I get it freezing again.

Regards,
Stephan
