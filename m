Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVAGTNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVAGTNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVAGTNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:13:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:13763 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261538AbVAGTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:12:36 -0500
Date: Fri, 7 Jan 2005 19:12:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Vladimir Saveliev <vs@namesys.com>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107191234.GA14108@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Saveliev <vs@namesys.com>, linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <20050107190545.GA13898@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107190545.GA13898@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now the big question is, what's synchronizing access to
> current->private_pages?

Umm, it's obviously correct as we're thread-local.  Objection taken back :)

