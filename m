Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWFWPSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWFWPSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWFWPSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:18:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751459AbWFWPSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:18:09 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060623145756.GD32694@infradead.org>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623145756.GD32694@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 23 Jun 2006 16:26:23 +0100
Message-Id: <1151076383.3856.1589.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-23 at 15:57 +0100, Christoph Hellwig wrote:
> Why is gfs2_sendfile wrapping generic_file_sendfile?

Might as well start with the easy one first :-) Now fixed in the git
tree. I think it was left over from when GFS used to do locking at this
level but as you point out, is no longer needed,

Steve.


