Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSE3XmZ>; Thu, 30 May 2002 19:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSE3XmY>; Thu, 30 May 2002 19:42:24 -0400
Received: from ns.suse.de ([213.95.15.193]:27146 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S290289AbSE3XmX>;
	Thu, 30 May 2002 19:42:23 -0400
Date: Fri, 31 May 2002 01:42:24 +0200
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 cpu selection (first hack)
Message-ID: <20020531014224.C9282@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020530225015.GA1829@werewolf.able.es> <3CF6B3AD.6010106@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 07:20:13PM -0400, Jeff Garzik wrote:

 > wonder if making the CPU features selectable is useful? i.e. provide an 
 > actual config option for MMX memcpy, F00F bug, WP, etc. Normal (current) 
 > logic is to look at the cpu selected, and deduce these options.

J.A's comment that most people compiling kernels shouldn't need to know
what bugs their CPU has before they pick it is a good one imo[1]

Also an explosion of CONFIG_ items where they can be sanely derived
from others doesn't make much sense imo.

    Dave.

[1] fsck, I sound like Eric.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
