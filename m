Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUDESCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUDESCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:02:15 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:49295 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263045AbUDESCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:02:12 -0400
Date: Mon, 5 Apr 2004 18:59:40 +0100
From: Dave Jones <davej@redhat.com>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk, cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.6] cpufreq longrun driver fix
Message-ID: <20040405175940.GO5688@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk, cpufreq@www.linux.org.uk
References: <20040405155012.GI2718@deep-space-9.dsnet> <20040405173835.GA7328@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405173835.GA7328@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > The following patch does even more, it tries every value from 80%
 > > to 10% in 10% steps, until it succeeds in lowering the performance.
 > > I'm not sure this is the best way to do it but in any case, 
 > > it works for me (and should continue to work for everybody else).
 > 
 > Patch looks good to me -- thanks, Stelian! 
 > Dave, could you merge it, please?

Yup, will be in cpufreq-bk soon, and the next -mm that
Andrew rolls up.

		Dave

