Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVJYE1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVJYE1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 00:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVJYE1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 00:27:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17100 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751451AbVJYE13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 00:27:29 -0400
Date: Tue, 25 Oct 2005 05:27:28 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8] FUSE improvements + VFS changes
Message-ID: <20051025042728.GK7992@ftp.linux.org.uk>
References: <E1EU5RZ-0005qg-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU5RZ-0005qg-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 06:45:05PM +0200, Miklos Szeredi wrote:
> The limitations are:
> 
>   1) open("foo", O_CREAT | O_WRONLY, 0444) or similar won't work
> 
>   2) ftruncate on a file not having write permission (but file opened
>      in write mode) will fail
> 
>   3) statfs() cannot return different values based on the path within
>      a filesystem

    4) mass of a body cannot vary depending on the way it's turned.

Horrible limitations, all of them...
