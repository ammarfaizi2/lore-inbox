Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWJJGpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWJJGpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWJJGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:45:35 -0400
Received: from main.gmane.org ([80.91.229.2]:9159 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965024AbWJJGpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:45:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Reinhard Tartler <siretart@tauware.de>
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Date: Tue, 10 Oct 2006 08:29:09 +0200
Message-ID: <87wt783cqy.fsf@hermes.olymp.tauware.de>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl01.83.171.151.131.ip-pool.nefkom.net
X-Url: http://tauware.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:4CpNNCAQtLHT72OBFrMhGb7gWgg=
Cc: hostap@shmoo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
>> Distributions _are_ shipping those tools already.  The problem is more
>> with older distributions where, for example, the kernel gets upgraded
>> but other stuff does not.  If a kernel upgrade happens, then the distro
>> needs to make sure userspace works with it.  That's nothing new.
>
> Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
> thought we saw a note saying that even Debian **unstable** didn't have
> a new enough version of the wireless-tools....

Debian is currently in (pre-) freeze mode, and new upstream versions of
core packages are uploaded very very carefully. To see whats going on
with the wireless-tools package, see [1, 2].

[3] shows that 29pre10 was uploaded to experimental on Thu,  4 May 2006

So you are right, debian unstable doesn't ship the latest version,
because that would have the potential to make problems with the release
of debian 4.0 (aka etch). The updated package however is there. If this
package should go to etch, because 2.6.18 is likely to be the kernel
etch ships, then both the maintainer and the release team needs to be
convinced about that.

[1] http://packages.debian.org/wireless-tools
[2] http://packages.qa.debian.org/wireless-tools
[3] http://packages.qa.debian.org/w/wireless-tools/news/20060504T210628Z.html

-- 
Gruesse/greetings,
Reinhard Tartler, KeyID 945348A4

