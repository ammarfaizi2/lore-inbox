Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTENWLC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbTENWLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:11:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262946AbTENWLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:11:00 -0400
Date: Wed, 14 May 2003 23:23:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mikhail Kruk <meshko@cs.brandeis.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible open/unlink race condition?
Message-ID: <20030514222348.GB10374@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.33.0305141727500.20287-100000@iole.cs.brandeis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0305141727500.20287-100000@iole.cs.brandeis.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 05:41:23PM -0400, Mikhail Kruk wrote:

> The description of file creation in the process 1 is completely made up, I 

So it is.  ->i_sem is held on parent directory both for creation and
removal.
