Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSA3CWF>; Tue, 29 Jan 2002 21:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSA3CVz>; Tue, 29 Jan 2002 21:21:55 -0500
Received: from ns.suse.de ([213.95.15.193]:40207 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288040AbSA3CVl>;
	Tue, 29 Jan 2002 21:21:41 -0500
Date: Wed, 30 Jan 2002 03:21:38 +0100
From: Dave Jones <davej@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
Message-ID: <20020130032138.H16379@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>, <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com> <1012351309.813.56.camel@phantasy> <3C574BD1.E5343312@zip.com.au> <1012357211.817.67.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012357211.817.67.camel@phantasy>; from rml@tech9.net on Tue, Jan 29, 2002 at 09:20:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 09:20:10PM -0500, Robert Love wrote:

 > I feared this too, but eventually I decided it was worth it and
 > benchmarks backed that up.  If nothing else this is yet-another-excuse
 > for locks that can spin-then-sleep.
 > I posted dbench results, which show a positive gain even on 2-way for
 > multiple client loads.

 did you benchmark with anything other than dbench ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
