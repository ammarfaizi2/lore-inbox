Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTIIRy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTIIRy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:54:29 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:61503 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264222AbTIIRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:54:28 -0400
Date: Tue, 9 Sep 2003 18:53:23 +0100
From: Dave Jones <davej@redhat.com>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dennis Freise <Cataclysm@final-frontier.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New ATI FireGL driver supports 2.6 kernel
Message-ID: <20030909175323.GB932@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mika Liljeberg <mika.liljeberg@welho.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dennis Freise <Cataclysm@final-frontier.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org> <20030908225401.GD681@redhat.com> <1063069344.28622.53.camel@dhcp23.swansea.linux.org.uk> <20030909075023.GA8065@redhat.com> <1063129307.777.8.camel@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063129307.777.8.camel@hades>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 08:41:47PM +0300, Mika Liljeberg wrote:
 > > For one it links in the GPL'd nvidia GART module.
 > Hmm, dunno about that:
 > $ grep -i license nvidia-agp.c
 > MODULE_LICENSE("GPL and additional rights");
 > All the rest seems to be under a BSD style license.

The 'additional rights' on AGPGART come from the time when
it was in the XFree86 tree. If anything its dual-license
GPL & X11.  The problem with 'additional rights' tags in
drivers is they rarely state what those rights are.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
