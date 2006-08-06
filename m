Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWHFDBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWHFDBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 23:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWHFDBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 23:01:50 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:64714 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751500AbWHFDBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 23:01:49 -0400
Date: Sat, 5 Aug 2006 21:01:47 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: dean gaudet <dean@arctic.org>
Cc: David Lang <dlang@digitalinsight.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060806030147.GG4379@parisc-linux.org>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org> <20060805222247.GQ29686@ca-server1.us.oracle.com> <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 04:28:29PM -0700, dean gaudet wrote:
> you can work around mutt's silly dependancy on atime by configuring it 
> with --enable-buffy-size.  so far mutt is the only program i've discovered 
> which cares about atime.

For the shell, atime is the difference between 'you have mail' and 'you
have new mail'.

I still don't understand though, how much does this really buy us over
nodiratime?
