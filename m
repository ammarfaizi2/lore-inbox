Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVIVPYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVIVPYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVIVPYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:24:54 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:42306 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030402AbVIVPYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bMgzUTvIhbaaJmUsw0ISxtQwT4q8h0tx+xbKq2p5PIicr6IxeDE8hnWbf9D7/wI6AR6wunJUyLUkC7Y0NWU8gwGV18nts0HnxtC92rIInPqcj3/gATR9hZ/4O511DOwWyTZkJ5lrq7Qf8dLp8pL51UnX4yA7uRxAHq2Kvs8QXbE=
Date: Thu, 22 Sep 2005 19:34:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip_conntrack_pptp: fix endian sparse warnings
Message-ID: <20050922153451.GA7519@mipter.zuzino.mipt.ru>
References: <20050921170539.GA10537@mipter.zuzino.mipt.ru> <20050922132833.GM26520@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922132833.GM26520@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:28:34PM +0200, Harald Welte wrote:
> btw, where can I get the latest sparse release?
> 
> linux-2.6.14-rc2/Documentation/sparse.txt still points to a dead
> directory at
> http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
> which now seems to be 404.
> 
> Are there no snapshots available?  Didn't anyone convre the bitkeeper
> repository to git or something else?  I'm a bit puzzled.


I use

rsync -avz --progress --delete \
	rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git/ \
	.git

to get latest sparse tree.

