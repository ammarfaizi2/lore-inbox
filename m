Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVHDSGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVHDSGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVHDSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:06:24 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:24868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261532AbVHDSGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:06:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aXvF1o9je/sS8R75ACe0UDfFiNbLl3HEugM9D+wlWylL33sIV/7iLt6C6MDiRO1bnpXtKpvbpzz2jpEzyamGmirYusHBMbZLGL5I6zRcHD+JzPIkUvKHdxhrbDkH2SgbHzorxNiM9rdnatM1O5v5gYVdaVv2fWEr2ZsfNZP8SJ4=
Message-ID: <8e6f947205080411067f7a9e78@mail.gmail.com>
Date: Thu, 4 Aug 2005 14:06:16 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Obsolete files in 2.6 tree
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <E1E0YrP-0000rm-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42DED9F3.4040300@gmail.com> <42F145ED.2060008@gmail.com>
	 <8e6f9472050803214250821160@mail.gmail.com>
	 <E1E0YrP-0000rm-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Well, don't know about anyone else, but I certainly don't use it
> > anymore. If anyone needs  a fully-functional befs driver, the easiest
> > route to that would probably be getting Haiku's befs driver to compile
> > in userland as a FUSE fs.
> 
> That has already been done:
> 
>   http://prdownloads.sourceforge.net/fuse/mountlo-i386-0.1.tar.gz
> 
> All is needed is a working FUSE installation, and the above binary, to
> be able to mount any filesystem image/partition.

I think you mis-understand. Mountlo seems to allow one to mount
(through FUSE) any filesystem image for which there is a linux kernel
kernel driver available. This is a very nice capability.

But what I speak of is to port the 100% feature-complete (and
well-tested) befs driver from the Haiku project's kernel to the FUSE 
interface. This should be a considerably easier task than porting it
to the linux kernel vfs interface. Among other reasons for this, parts
of Haiku's kernel (including their befs driver) are written in c++.

-- 
Will Dyson
