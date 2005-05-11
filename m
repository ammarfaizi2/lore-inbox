Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVEKRuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVEKRuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVEKRuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:50:46 -0400
Received: from peabody.ximian.com ([130.57.169.10]:59777 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262020AbVEKRt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:49:28 -0400
Subject: Re: [PATCH] sync_sb_inodes cleanup
From: Robert Love <rml@novell.com>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <1115797036.29007.359.camel@tribesman.namesys.com>
References: <1115737238.4456.320.camel@tribesman.namesys.com>
	 <1115739301.6810.15.camel@betsy>
	 <1115797036.29007.359.camel@tribesman.namesys.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 13:49:24 -0400
Message-Id: <1115833764.6810.32.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 11:37 +0400, Vladimir Saveliev wrote:

> I did not want to un-const start. It would be required for the
> assignment move, wouldn't it?

Well, the const is just a programming convention.  It is useful here,
but just a convention; removing it changes nothing behavior-wise.  Your
patch, though, changes behavior.

How bad do you need to push the spin locks into the function?

	Robert Love


