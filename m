Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVIEPpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVIEPpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVIEPpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:45:53 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:58676 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932214AbVIEPpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:45:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WhT8G5sj03paNlhCuSsJw6wQz8y4sgU5BTYal2qjNpBq9U7gqw/xgGUH2INPxEwOJaD1k2DrNyEEpoBEND5Vsy3n2PgSdpCcD0qbSI0pzR/1YuBpbfrKTfDF9cfpjTEkeYwqumW4JVhE81XRI5PdaFVdBCa5qlf3x5BKrTH9Y60=
Date: Mon, 5 Sep 2005 19:55:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk
Subject: Re: [PATCHSET] 2.6.13-git3-bird1
Message-ID: <20050905155522.GA8057@mipter.zuzino.mipt.ru>
References: <20050905035848.GG5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905035848.GG5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 04:58:48AM +0100, viro@ZenIV.linux.org.uk wrote:
> 	While waaaaay overdue, "fixes and sparse annotations" tree is finally
> going public.  This version is basically a starting point - there will be
> much more stuff to merge.

> 	Current patchset is on ftp.linux.org.uk/pub/people/viro/ -
> patch-2.6.13-git3-bird1.bz2 is combined patch, patchset/* is the splitup.
> Long description of patches is in patchset/set*, short log is in the end of
> this posting.  Current build and sparse logs are in logs/*/{log17b,S-log17b}.

Those who want to help with endian annotations (sparse -Wbitwise) are
welcome at ftp://ftp.berlios.de/pub/linux-sparse/logs/

[allmodconfig + CONFIG_DEBUG_INFO=n] x [alpha, i386, parisc, ppc, ppc64,
s390, sh, sh64, sparc, sparc64, x86_64]

-git5 is compiling right now.

