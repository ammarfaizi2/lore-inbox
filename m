Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWCHJVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWCHJVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWCHJVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:21:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:489 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750814AbWCHJVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:21:03 -0500
Subject: Re: [PATCH] Prevent NULL pointer deref in grab_swap_token
From: Arjan van de Ven <arjan@infradead.org>
To: Dean Roe <roe@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, riel@redhat.com
In-Reply-To: <20060307211344.GA2946@sgi.com>
References: <20060307211344.GA2946@sgi.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 10:20:57 +0100
Message-Id: <1141809658.3050.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 15:13 -0600, Dean Roe wrote:
> grab_swap_token() assumes that the current process has an mm struct,
> which is not true for kernel threads invoking get_user_pages(). 

well WHICH user ? ;)


