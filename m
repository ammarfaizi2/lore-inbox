Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTFKUvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTFKUvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:51:43 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:23476 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264536AbTFKUte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:49:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.39056.810025.975744@gargle.gargle.HOWL>
Date: Wed, 11 Jun 2003 17:01:04 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       willy@w.ods.org, marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030611222346.0a26729e.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephan> I switched to rc8 (SMP, apic), took three cycles until it
Stephan> failed.  rc8 (SMP, apic, HIGHIO) failed on the first try.  I
Stephan> thought HIGHIO could make a difference if there were inherent
Stephan> problems with bounce buffers. Unfortunately this seems not
Stephan> the case.

I'm doing testing on 2.5.70-mm3, SMP, APIC, PREEMPT with an AIC7880
driving a DLT7000 along with some idle disks on the same bus.  I'm
dumping data to tape and verifying it.  Once I get more data, I'll
followup.

John
