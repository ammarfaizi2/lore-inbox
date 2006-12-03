Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757055AbWLCMH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbWLCMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759621AbWLCMH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:07:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23685 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757055AbWLCMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:07:25 -0500
Subject: Re: [PATCH  v2 03/13] Provider Methods and Data Structures
From: Arjan van de Ven <arjan@infradead.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061202224947.27014.59189.stgit@dell3.ogc.int>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224947.27014.59189.stgit@dell3.ogc.int>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 03 Dec 2006 13:07:18 +0100
Message-Id: <1165147639.3233.211.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 16:49 -0600, Steve Wise wrote:

> +
> +static struct ib_ah *iwch_ah_create(struct ib_pd *pd,
> +				    struct ib_ah_attr *ah_attr)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}


-ENOSYS is just about ALWAYS a bug in that it's guaranteed to be the
wrong error code ;)


