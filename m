Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289985AbSAQXNQ>; Thu, 17 Jan 2002 18:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289959AbSAQXM4>; Thu, 17 Jan 2002 18:12:56 -0500
Received: from ns.suse.de ([213.95.15.193]:25349 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289985AbSAQXMq>;
	Thu, 17 Jan 2002 18:12:46 -0500
Date: Fri, 18 Jan 2002 00:12:44 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jes Sorensen <jes@wildopensource.com>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
Message-ID: <20020118001244.B28183@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jes Sorensen <jes@wildopensource.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0201171804510.23659-100000@Appserv.suse.de> <Pine.LNX.4.33.0201171433260.3114-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201171433260.3114-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 17, 2002 at 02:35:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 02:35:30PM -0800, Linus Torvalds wrote:
 > No. Could we please integrate this not with ACPI, but with the much more
 > limited "arch/i386/kernel/acpitable.c", which does NOT imply full ACPI,
 > only scanning the tables for information in static format (like the irq
 > routing stuff).

 I was under the impression that the Intel ACPI folks had things in
 mind for acpitable.c along the lines of 'rm', in favour of having 
 their new interpretor do a "Load, setup, get the hell out" approach
 for those that didn't want it staying around.

 Either way, I agree improving our ACPI support is a better solution
 in the long run.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
