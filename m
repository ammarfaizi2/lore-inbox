Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWCaItP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWCaItP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWCaItP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:49:15 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:1262 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751243AbWCaItO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:49:14 -0500
From: CIJOML <cijoml@volny.cz>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.16 - cpufreq doesn't find Celeron (Pentium4/XEON) processor
Date: Fri, 31 Mar 2006 10:48:14 +0200
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
References: <200603210902.19335.cijoml@volny.cz> <200603211034.38393.cijoml@volny.cz> <20060324082325.GA7645@suse.de>
In-Reply-To: <20060324082325.GA7645@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603311048.14616.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

yes, it is clockmod, but problem is, that my laptop doesn't support 
throttling, so this is only chance for me to do scaling...

cat /proc/acpi/processor/CPU0/throttling
<not supported>

Regards

Michal

Dne pá 24. bøezna 2006 09:23 Stefan Seyfried napsal(a):
> On Tue, Mar 21, 2006 at 10:34:38AM +0100, CIJOML wrote:
> > http://www.freewebs.com/duckzland/t240.html
>
> ...is using p4-clockmod which is basically useless for power saving
> It does the same as throttling IIUC.
