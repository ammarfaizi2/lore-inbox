Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSGVLRl>; Mon, 22 Jul 2002 07:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGVLQR>; Mon, 22 Jul 2002 07:16:17 -0400
Received: from ns.suse.de ([213.95.15.193]:27404 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316820AbSGVLQI>;
	Mon, 22 Jul 2002 07:16:08 -0400
Date: Mon, 22 Jul 2002 13:19:15 +0200
From: Dave Jones <davej@suse.de>
To: martin@dalecki.de
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
Message-ID: <20020722131915.K27749@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, martin@dalecki.de,
	Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> <3D3BE17F.3040905@evision.ag> <20020722125347.B16685@lst.de> <3D3BE4C7.2060203@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3BE4C7.2060203@evision.ag>; from dalecki@evision.ag on Mon, Jul 22, 2002 at 12:56:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:56:07PM +0200, Marcin Dalecki wrote:

 > > Please don't remove the trailing commas in the enums.  they make adding
 > > to them much easier and are allowed by gcc (and maybe C99, I'm not
 > > sure).
 > It's an GNU-ism. If you have any problem with "adding vales", just
 > invent some dummy end-value. I have a problem with using -pedantic.

If you feel like doing 'warnings patrol', then there are a bunch of
more important regular warnings[1] that need fixing up without having to look
through the pedantic output. Last I checked the pedantic stuff flagged
a lot of bits that the fix ended up uglier than the warning
(which 99.9% of people won't ever see anyway)

        Dave

[1] Although more important would be stabilising IDE, but thats a sidenote.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
