Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUIMNlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUIMNlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUIMNlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:41:21 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26890 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266725AbUIMNlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:41:03 -0400
Date: Mon, 13 Sep 2004 14:40:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040913144000.B25118@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <nikita@clusterfs.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <200409131248.53098.rjw@sisk.pl> <16709.32973.307634.787473@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16709.32973.307634.787473@thebsh.namesys.com>; from nikita@clusterfs.com on Mon, Sep 13, 2004 at 03:13:17PM +0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just don't set ->permission for reiser4 and kill the whole perm_plugin
bullshit.  This fixes the issue by removing a few hundred lines of code which
is always a good idea.
