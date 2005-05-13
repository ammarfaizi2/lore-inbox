Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVEMRFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVEMRFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVEMRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:05:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9138 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261729AbVEMRFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:05:49 -0400
Date: Fri, 13 May 2005 18:06:02 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 12:44:03PM +0200, Miklos Szeredi wrote:
> Bind mount from a foreign namespace results in

... -EINVAL
