Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTJGXtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTJGXtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:49:42 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:39038 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262117AbTJGXtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:49:40 -0400
Date: Wed, 8 Oct 2003 00:49:02 +0100
From: Dave Jones <davej@redhat.com>
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE: The hardware reports... (AMD Duron)
Message-ID: <20031007234902.GB10471@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Juliusz Chroboczek <jch@pps.jussieu.fr>,
	linux-kernel@vger.kernel.org
References: <tppth8j07y.fsf@helium.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tppth8j07y.fsf@helium.pps.jussieu.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 09:50:57PM +0200, Juliusz Chroboczek wrote:
 > Under both 2.6.0test4 and test6, I'm fairly regularly getting the
 > following at boot time:
 > 
 >  MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
 >  Bank 0: e603800000000175
 > 
 > The machine is a Compaq Presario 711, with a 950MHz Mobile Duron
 > (family 6 model 7 stepping 1 according to /proc/cpuinfo).
 > 
 > The Intel docs seem to imply that this is something memory-related, I
 > couldn't find the relevant AMD docs.
 > 
 > Would somebody be so kind as to explain what the above means?

Probably spurious, a fix was merged on the 29th. Test6 came out on 
the 28th, so just missed...

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
