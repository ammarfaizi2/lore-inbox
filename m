Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUIGGyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUIGGyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUIGGyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:54:33 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:20678 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267666AbUIGGyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:54:32 -0400
Message-ID: <21d7e99704090623544c6ecaf5@mail.gmail.com>
Date: Tue, 7 Sep 2004 16:54:27 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: [BUG] r200 dri driver deadlocks
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	"Felix  =?ISO-8859-1?Q?=20K=FChling=22?= <fxkuehl@gmx.de>, Lee Revell <rlrevell@joe-job.com>, diablod3@gmail.com, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org"
			^-missing closing '"' in token
In-Reply-To: <20040907063442.3574.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040906125115.0d49db62.felix@trabant>
	 <20040907063442.3574.qmail@web11906.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dose the DRM varify that the cmds are in this order?  Why not just have
> the DRM 'sort' the cmds?  A simple bouble sort would have no more overhead
> then the check for correct order, but it would fix missordered cmd
> streams.
> 
> Once this is done the statement holds true, userland stuff should never...
> 

Feel free to implement it and profile it, but there are so many ways
to lock up a radeon chip it is scary, the above was just one example,
some days if you look at it funny it can lockup :-), it is accepted
that userland can crap out 3D chips, the Intel ones are fairly easy to
hangup also..

Dave.
