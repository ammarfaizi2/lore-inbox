Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317910AbSGZRwe>; Fri, 26 Jul 2002 13:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317908AbSGZRwe>; Fri, 26 Jul 2002 13:52:34 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:13327 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317905AbSGZRwc>; Fri, 26 Jul 2002 13:52:32 -0400
Date: Fri, 26 Jul 2002 18:55:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kurt Garloff <garloff@suse.de>, Alexander Viro <viro@math.psu.edu>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] sd_many done right (1/5)
Message-ID: <20020726185545.B18629@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kurt Garloff <garloff@suse.de>, Alexander Viro <viro@math.psu.edu>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl> <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu> <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl> <20020726175027.GC2746@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726175027.GC2746@clusterfs.com>; from adilger@clusterfs.com on Fri, Jul 26, 2002 at 11:50:27AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:50:27AM -0600, Andreas Dilger wrote:
> Actually, one interesting aspect of the EVMS vs. device-mapper argument
> going on that has totally been missed is that EVMS can do management of
> ALL disk block devices.

That's only natural as it try to duplicate the whole Linux block layer.
But it's everything but a good idea.

