Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWBXXXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWBXXXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWBXXXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:23:14 -0500
Received: from main.gmane.org ([80.91.229.2]:47282 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964770AbWBXXXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:23:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
Date: Fri, 24 Feb 2006 15:22:27 -0800
Message-ID: <87oe0wxryk.fsf@benpfaff.org>
References: <200602242149.42735.jesper.juhl@gmail.com>
	<1140821964.3615.95.camel@lade.trondhjem.org>
	<9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
	<20060224231749.GH27946@ftp.linux.org.uk>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:IlBYiPaYcVKQGHo7YOCdNRvTZcg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> On Sat, Feb 25, 2006 at 12:01:32AM +0100, Jesper Juhl wrote:
>> No need for that. It's just something that ICC complains about
>> "storage class not being first" - gcc doesn't care.
>
> Neither does C99, so ICC really should either STFU or make that warning
> independent from the rest and possible to turn off...

C99 does deprecate "const static":

     6.11.5 Storage-class specifiers
1    The placement of a storage-class specifier other than at the
     beginning of the declaration specifiers in a declaration is
     an obsolescent feature.

-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org

