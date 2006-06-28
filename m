Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWF1F4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWF1F4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWF1F4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:56:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161136AbWF1F4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:56:18 -0400
Date: Wed, 28 Jun 2006 06:56:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, viro@ftp.linux.org.uk, serue@us.ibm.com
Subject: Re: [PATCH 00/20] Mount writer count and read-only bind mounts (v3)
Message-ID: <20060628055611.GA4023@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, herbert@13thfloor.at,
	viro@ftp.linux.org.uk, serue@us.ibm.com
References: <20060627221436.77CCB048@localhost.localdomain> <20060627183822.667d9d49.akpm@osdl.org> <1151459436.24103.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151459436.24103.70.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 06:50:36PM -0700, Dave Hansen wrote:
> > umm, what's it all for?
> 
> Mostly for vserver, for now.  They allow a filesystem to be r/w, but
> have r/o views into it.  This is really handy so that every vserver can
> use a common install but still allow the administrator to update it.

It's useful for much more then just containers.  Even with a plain chroot
or just any real multi-user system it's massively useful.

