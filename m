Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVKWUf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVKWUf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVKWUfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:35:48 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:40632 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932395AbVKWUfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:35:02 -0500
Date: Wed, 23 Nov 2005 21:34:48 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051123203448.GF28142@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz> <20051122163550.160e4395.akpm@osdl.org> <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au> <20051123051358.GB7573@fi.muni.cz> <20051123131417.GH24091@fi.muni.cz> <20051123110241.528a0b37.akpm@osdl.org> <20051123202438.GE28142@fi.muni.cz> <9a8748490511231232y2112475bwb19aa73dfa38d916@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490511231232y2112475bwb19aa73dfa38d916@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
: On 11/23/05, Jan Kasprzak <kas@fi.muni.cz> wrote:
: >
: >         Hmm, it does not show anything but the header. Should I enable
: > something special in the kernel?
: >
: 
: CONFIG_MAGIC_SYSRQ=y
: (it's in 'Kernel hacking')
: 
	I of course have this:

# zgrep -i SYSRQ /proc/config.gz
CONFIG_MAGIC_SYSRQ=y
#

otherwise I would not have /proc/sysrq-trigger file at all, and I would not
be able to post the sysrq-m outputs like I did earlier today.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
