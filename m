Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVFUXhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVFUXhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVFUXdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:33:51 -0400
Received: from graphe.net ([209.204.138.32]:25023 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262446AbVFUXa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:30:29 -0400
Date: Tue, 21 Jun 2005 16:30:19 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <42B8987F.9000607@pobox.com>
Message-ID: <Pine.LNX.4.62.0506211628550.25251@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com>
 <1119368364.3949.236.camel@betsy> <Pine.LNX.4.62.0506211222040.21678@graphe.net>
 <42B8987F.9000607@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Jeff Garzik wrote:

> Non-blocking file I/O is an open issue.
> 
> AIO is probably a better path.

AIO is requiring you to poll and check if I/O is complete. select() does 
not require any polling and just needs to be made to work the way it was 
intended to.

