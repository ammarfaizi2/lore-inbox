Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVBDOCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVBDOCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbVBDOCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:02:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261820AbVBDN5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:57:19 -0500
Subject: Re: ext3 extended attributes refcounting wrong?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <16899.29744.75308.6946@alkaid.it.uu.se>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
	 <1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
	 <16899.12681.98586.426731@alkaid.it.uu.se>
	 <1107513634.2245.46.camel@sisko.sctweedie.blueyonder.co.uk>
	 <16899.29744.75308.6946@alkaid.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107525405.2245.387.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 04 Feb 2005 13:56:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-02-04 at 13:10, Mikael Pettersson wrote:

>  > Plain upstream 2.4.28?  If so, that's probably the trouble, as 2.4
>  > doesn't have any xattr support, so if you delete a file on 2.4 it won't
>  > delete the xattr block for it.
> 
> 2.4.28 - certainly I've used that at lot.

But plain upstream 2.4.28, or a vendor kernel?  Like I just said,
upstream doesn't have xattr support.

>  > > How recent was that fix? Maybe I'm seeing the aftereffects of
>  > > pre-fix corruption?
>  > 
>  > It went in on the 15th of January this year.
> 
> Is it in 2.4.29?

No, it couldn't be.  It was an xattr fix.  2.4.29 doesn't have xattrs,
so the fix isn't relevant there.

--Stephen

