Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbUK3Goi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUK3Goi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUK3Goi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:44:38 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:39912 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261977AbUK3Gog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:44:36 -0500
Date: Tue, 30 Nov 2004 07:44:35 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130064435.GA5575@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
	hch@infradead.org, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 03:00:17PM -0800, Linus Torvalds wrote:

> And that's really the fundamental issue. The kernel does not care what
> user land does. The kernel exports functionality, the kernel does _not_
> ask user land to help.

Reminds me of the Klingon programming language:

http://tinyurl.com/4rjco

7 : "Klingon function calls do not have 'parameters' -- they have
'arguments' -- and they ALWAYS WIN THEM."

8 : "What is this talk of 'release'? Klingons do not make software
'releases.' Our software 'escapes' leaving a bloody trail of designers and
quality assurance people in its wake."

9 : "Indentation?! - I will show you how to indent when I indent your
skull!"

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
