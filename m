Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWEUQDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWEUQDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEUQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 12:03:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751277AbWEUQDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 12:03:40 -0400
Date: Sun, 21 May 2006 12:03:32 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521160332.GA8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, dragoran <dragoran@feuerpokemon.de>,
	linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521085015.GB2535@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 01:50:15AM -0700, Chris Wedgwood wrote:
 > On Sun, May 21, 2006 at 10:35:28AM +0200, dragoran wrote:
 > 
 > > IA32 syscall 311 from mozilla-xremote not implemented
 > > IA32 syscall 311 from firefox-bin not implemented
 > > IA32 syscall 311 from mplayer not implemented
 > > what is syscall 311  and what effect does this have?
 > 
 > sys_set_robust_list, I think it's futex related
 > 
 > > I am using 2.6.16-1.2111_FC5 (2.6.16.14)
 > 
 > probably best to bitch to Red Hat about this

It's a glibc problem really. They started using that syscall,
and 2.6.16 doesn't have it.  I might backport it to our next
.16 update just to shut it up if .17 takes much longer.

		Dave

-- 
http://www.codemonkey.org.uk
