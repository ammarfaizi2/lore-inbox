Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUBZA1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUBZA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:27:18 -0500
Received: from H28.C29.B96.tor.eicat.ca ([66.96.29.28]:58554 "EHLO
	H28.C29.B96.tor.eicat.ca") by vger.kernel.org with ESMTP
	id S262456AbUBZA1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:27:17 -0500
Date: Wed, 25 Feb 2004 19:27:15 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Hayim Shaul <hayim@post.tau.ac.il>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, akpm@osdl.org,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Latest AIO patchset
Message-ID: <20040225192715.B11294@kvack.org>
References: <20040224160341.GA11739@in.ibm.com> <Pine.LNX.4.44.0402252026460.12841-100000@soul.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0402252026460.12841-100000@soul.math.tau.ac.il>; from hayim@post.tau.ac.il on Wed, Feb 25, 2004 at 08:45:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 08:45:29PM +0200, Hayim Shaul wrote:
> What exactly is the O_DIRECT flag? When I add this flag to the open func
> it fails.
> 
> More specificaly, this function fails
>   open("filename", O_RDWR | O_DIRECT | O_LARGEFILE | O_CREAT, S_IRWXU);   
> 
> but this one succeeds
>   open("filename", O_RDWR | O_LARGEFILE | O_CREAT, S_IRWXU);   
> 
> I'm running linux 2.6.0 with libaio 0.3.92.

Which filesystem?  Not all support O_DIRECT.

		-ben
