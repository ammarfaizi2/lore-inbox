Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269659AbUICMcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbUICMcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUICMcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:32:45 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39941 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269659AbUICMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:32:40 -0400
Date: Fri, 3 Sep 2004 13:32:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       umbrella-devel@lists.sourceforge.net
Subject: Re: Getting full path from dentry in LSM hooks
Message-ID: <20040903133238.A4145@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	umbrella-devel@lists.sourceforge.net
References: <41385FA5.806@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41385FA5.806@cs.aau.dk>; from ks@cs.aau.dk on Fri, Sep 03, 2004 at 02:12:21PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 02:12:21PM +0200, Kristian Sørensen wrote:
> I have a short question, concerning how to get the full path of a file 
> from a LSM hook.
> 
> - If the "file" of the dentry is located in the root filesystem: no
>    problem - simply traverse the dentrys, to generate the path.
> 
> - If the "file" is mounted from another partition, you do not get the
>    full path by traversing the dentrys.

There is no canonical full path for a given dentry.

