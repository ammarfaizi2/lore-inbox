Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWDSAPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWDSAPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWDSAPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:15:37 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:46327 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750924AbWDSAPg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:15:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iRhkhmF2B3lkgA2JQJ21k6XG3mvkdvsx2b9HXzg9LGiNIZQNyyCGHX8bC7Ezr+NYvVItneOLjUggMtww8wa77naiXi3w1UGOlcJQq/M1oy1GgPQ2qEi051OBOmW6tt1RSGUwYCyhjls/9e4YQyN91XeifnhDjXcHJJRBbL5jVWA=
Message-ID: <35fb2e590604181715o5c381407ya80bdc3beedc5b68@mail.gmail.com>
Date: Wed, 19 Apr 2006 01:15:34 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "David Lang" <dlang@digitalinsight.com>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0604181550380.22439@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060418234156.GA28346@apogee.jonmasters.org>
	 <Pine.LNX.4.62.0604181550380.22439@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, David Lang <dlang@digitalinsight.com> wrote:

>    would it be possible to have something less then an initrd that would
> allow the firmware blob to be packaged with the kernel?

With some modifications perhaps. I don't know if I see the value tbh :-)

> Your approach is just fine if the things that will need firmware are
> compiled as modules

Hmmm. Yeah. I'm not sure what the general feeling is on this - I'm
tempted to say that we expect modules to be used and that if they're
not then the vendor/user has to do the hoop jumping for themselves.
This code won't stop you from making a monolithic kernel and
satisfying any module requirements for yourself :-)

Jon.
