Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWCXSwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWCXSwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWCXSwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:52:44 -0500
Received: from THUNK.ORG ([69.25.196.29]:8160 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932592AbWCXSwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:52:43 -0500
Date: Fri, 24 Mar 2006 13:52:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324185237.GB18020@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324143239.GB14508@goober>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 06:32:39AM -0800, Valerie Henson wrote:
> Note that ext3's habit of clearing indirect blocks on truncate would
> break some things I want to do in the future. (Insert secret plans
> here.)

This is fixable, but it would require making the truncate code (even
more) complicated.....

						- Ted
