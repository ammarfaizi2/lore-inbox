Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVDNXaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDNXaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDNXaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:30:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25317 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261649AbVDNXaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:30:00 -0400
Date: Fri, 15 Apr 2005 00:29:58 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Franco Sensei <senseiwa@tin.it>
Cc: David Lang <david.lang@digitalinsight.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
Message-ID: <20050414232958.GY8859@parcelfarce.linux.theplanet.co.uk>
References: <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz> <425E9FE2.6090102@tin.it> <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz> <425EC778.4070009@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425EC778.4070009@tin.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 02:41:44PM -0500, Franco Sensei wrote:
> The global feeling about kernel is that it seems that you don't care 
> about the purpose of your task, which of course is not the kernel by 
> itself. It can't be. It's about what it does (and already does it well), 
> and what it provides to third-parties: the kernel and the API given to 
> the outside world, since the kernel is not alone... and will never be of 
> course! ;)

Elegant.  Very elegant.  Admirable exercise in misdirection - the word
"third-party" used to conflate all things non-kernel with 3rd party
kernel modifications.  Followed by appeals to civic obligations, no less.

Of course, that doesn't change the simple fact: "outside world" is not
a single entity.  There are API warranties for userland.  There's no
API warranties for 3rd-party kernel modifications.

Moreover, unless you manage to get the list of functions and data
types exported to modules somewhere within an order of magnitude
from the corresponding userland list (i.e. syscalls and types involved),
you are asking everybody to increase the size of API being preserved
at least tenfold.  As it is, that would be "by factor of 200-300".

If you manage to convince module authors to live with the export list
cut down by that much - come back and we'll have something to talk
about.
