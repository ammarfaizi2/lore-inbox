Return-Path: <linux-kernel-owner+w=401wt.eu-S932254AbXAIRHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbXAIRHg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXAIRHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:07:35 -0500
Received: from pat.uio.no ([129.240.10.15]:60066 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbXAIRHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:07:34 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Kara <jack@suse.cz>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
In-Reply-To: <20070109170426.GB23174@atrey.karlin.mff.cuni.cz>
References: <20070108111852.ee156a90.akpm@osdl.org>
	 <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
	 <20070109122644.GB1260@atrey.karlin.mff.cuni.cz>
	 <1168360778.6054.26.camel@lade.trondhjem.org>
	 <20070109170426.GB23174@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 12:07:05 -0500
Message-Id: <1168362425.6054.41.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 0FF4F308109EAD33962E1D905DA39E916DEBF04E
X-UiO-SPAM-Test: 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 18:04 +0100, Jan Kara wrote:
>   But once you have MS_RDONLY set, there should be no modifications of
> the underlying filesystem, should they? And I have understood that the
> only problem is modifying the filesystem underneath unionfs. But maybe
> I'm missing something.

Remote filesystems. The MS_RDONLY bit on your client means bugger all to
the server and all the other clients.

Trond

