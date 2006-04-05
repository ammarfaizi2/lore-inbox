Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWDEQSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWDEQSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDEQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:18:08 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:59522 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751226AbWDEQSI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:18:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KusB/50t2/S3A8snfQ3QXrTkbcYH279fTCQ59x8kBnXqz5Y5C3LJ7q0xANzOI2/oidNePsscMbeYMxcaSP0S7QTy4twUzQOrPgVq3CgXOhUxwa7btfWFLCloS6vL6jxlctEQDLOQJvt9/DdjABVU4fQcZAyCwD1xzlAdWNT113w=
Message-ID: <9e4733910604050918s72fc16acla569c6f244e01b9e@mail.gmail.com>
Date: Wed, 5 Apr 2006 12:18:07 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20060405154629.GJ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060404235634.696852000@quad.kroah.org>
	 <20060404235947.GD27049@kroah.com>
	 <20060405190928.17b9ba6a.vsu@altlinux.ru>
	 <20060405152123.GH27946@ftp.linux.org.uk>
	 <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com>
	 <20060405153957.GI27946@ftp.linux.org.uk>
	 <9e4733910604050843h3f6d0cdai8bfa3888b645c9b3@mail.gmail.com>
	 <20060405154629.GJ27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Wed, Apr 05, 2006 at 11:43:15AM -0400, Jon Smirl wrote:
> > > How about _NOT_ using sysfs and just having ->read()/->write() on a file in fs
>               ^^^^^^^^^^^^^^^^^

Where does this file come from? A device node?


> > > of your own?  ~20 lines for all of it, not counting #include...
> >
> > Sysfs attributes allow full read/write on their file handles. But
>   ^^^^^^^^^^^^^^^^
> > GregKH has been discouraging that.
>


--
Jon Smirl
jonsmirl@gmail.com
