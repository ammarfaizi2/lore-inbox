Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265557AbUFCOiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUFCOiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUFCOg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:36:26 -0400
Received: from [213.146.154.40] ([213.146.154.40]:52881 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264304AbUFCOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:33:40 -0400
Date: Thu, 3 Jun 2004 15:33:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       trond.myklebust@fys.uio.no, anton@samba.org
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040603143338.GA16957@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de, kevcorry@us.ibm.com,
	arjanv@redhat.com, trond.myklebust@fys.uio.no, anton@samba.org
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com> <20040603135952.GB16378@infradead.org> <20040603141922.GI4423@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603141922.GI4423@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:19:22PM +0200, Lars Marowsky-Bree wrote:
> The logic that _all_ modules and functionality need to be "in the tree"
> right from the start for hooks to be useful is flawed, I'm afraid.

And btw, I didn't say from the beginning.  I just want a comitment from
the lustre folks that they're merging it so we can work out the rough edges
together.  There's not much of a problem doing the merge spread over a few
kernel releases.

> Lustre alone would be, roughly, ~10MB more sources, just in the kernel.

I think for mainline mostly the client, aka the llite directory would
be interesting, so a linux box can simply join the lustre cluster.  the
metadata server and even worse the object storage box mods would require
tons of work to get anywhere a mergeable shape and are less interesting
anyway.

