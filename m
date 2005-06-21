Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVFUUh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVFUUh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFUUfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:35:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52137 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262311AbVFUUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:24:55 -0400
Date: Tue, 21 Jun 2005 21:24:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621202448.GB30182@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B87318.80607@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans, we had this discussion before.  And the consensus was pretty simple:
the disk structure plugins are your business and fine to keep.  The
higher-level pluging that just add another useless abstraction below
file_operation/inode_operation/etc.  are not.  keep the former and kill
the latter and you're one step further.
