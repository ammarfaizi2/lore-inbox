Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTCERI7>; Wed, 5 Mar 2003 12:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTCERI7>; Wed, 5 Mar 2003 12:08:59 -0500
Received: from ns.suse.de ([213.95.15.193]:4868 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267218AbTCERI5>;
	Wed, 5 Mar 2003 12:08:57 -0500
Date: Wed, 5 Mar 2003 18:19:27 +0100
From: Dave Jones <davej@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.64
Message-ID: <20030305181927.C20788@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com> <20030305143608.A24878@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030305143608.A24878@infradead.org>; from hch@infradead.org on Wed, Mar 05, 2003 at 02:36:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:36:09PM +0000, Christoph Hellwig wrote:
 > >   o [WATCHDOG] Remove old unneeded borken module locking
 > 
 > You just removed the nowayout functionality..

Only the bits that did the module locking crap, which
is unnecessary afaics.  If you look at the files touched,
there's still nowayout used in the other functions.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
