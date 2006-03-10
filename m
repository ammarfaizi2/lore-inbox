Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWCJH7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWCJH7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCJH7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:59:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60620 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750820AbWCJH73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:59:29 -0500
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, sct@redhat.com, jack@suse.cz,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net
In-Reply-To: <20060309152254.743f4b52.akpm@osdl.org>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	 <20060309152254.743f4b52.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 08:59:16 +0100
Message-Id: <1141977557.2876.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not sure that PageMappedToDisk() gets set in all the right places
> though - it's mainly for the `nobh' handling and block_prepare_write()
> would need to be taught to set it.  I guess that'd be a net win, even if
> only ext3 uses it..

btw is nobh mature enough yet to become the default, or to just go away
entirely as option ?

