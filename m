Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUHRTSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUHRTSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUHRTSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:18:07 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:15270 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267536AbUHRTSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:18:04 -0400
Date: Wed, 18 Aug 2004 12:18:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Shriram R <shriram1976@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Effect of deleting executables of running programs
Message-ID: <20040818191802.GC7749@taniwha.stupidest.org>
References: <20040818181646.28610.qmail@web11412.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818181646.28610.qmail@web11412.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 11:16:46AM -0700, Shriram R wrote:

> a) I always thought that once a job is running, the executable is
> entirely loaded into memory and the abcd.out file is no longer
> needed.

Not always, but it doesn't matter since the file actually is removed
from disk until the the last running instance terminates.

> If so, then why does the a running job crash on deleting abcd.out?

I have no idea.  But removing an executable whilst running isn't
uncommon, when you upgrade ayour machine this happens many times with
applications and libraries.

> b) To what extent can I trust that the rest of the 6-7 jobs that are
> running have not been affected by this deletion of "abcd.out" ?

Since one crashed already and there are no details as to why I have no
idea.


  --cw
