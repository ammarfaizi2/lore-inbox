Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbTGHN5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267347AbTGHN4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:56:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36072 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267335AbTGHNz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:55:58 -0400
Date: Wed, 9 Jul 2003 01:15:19 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Wim ten Have <wtenhave@sybase.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: Bug fix in AIO initialization
Message-ID: <20030709011519.A2412@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <41F331DBE1178346A6F30D7CF124B24B2A4880@fmsmsx409.fm.intel.com> <20030708115345.5e6e5bbc.wtenhave@sybase.com> <20030708234326.A2352@in.ibm.com> <20030708144121.241749f6.wtenhave@sybase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708144121.241749f6.wtenhave@sybase.com>; from wtenhave@sybase.com on Tue, Jul 08, 2003 at 02:41:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 02:41:21PM +0200, Wim ten Have wrote:
> On Tue, 8 Jul 2003 23:43:26 +0530
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> 
> > Is this with vanilla 2.5 kernels or recent -mm kernels ?
> 
>   vanilla 2.5 kernels
> 
> > Are you doing async O_DIRECT reads/writes or regular filesystem
> > aio read/writes ?
> 
>   both.

Regular filesystem aio reads/writes aren't async at the
moment in the vanilla 2.5 tree, so that would be expected, but
you say you are seeing this with O_DIRECT as well ... 

What kind of i/o sizes and loads are involved when you observe 
this with O_DIRECT AIO ? Which filesystem are you using ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

