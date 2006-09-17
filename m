Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWIQGik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWIQGik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 02:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWIQGij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 02:38:39 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:5087 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932226AbWIQGij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 02:38:39 -0400
Date: Sun, 17 Sep 2006 02:38:31 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dhowells@redhat.com
Subject: Re: [PATCH 0 of 11] Use SEEK_{SET,CUR,END} instead of hardcoded values
Message-ID: <20060917063831.GC28659@filer.fsl.cs.sunysb.edu>
References: <patchbomb.1158455366@turing.ams.sunysb.edu> <450CC50F.2090501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450CC50F.2090501@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 01:46:23PM +1000, Nick Piggin wrote:
> Josef 'Jeff' Sipek wrote:
> >In July, David Howells added SEEK_{SET,CUR,END} definitions to 
> >include/linux/fs.h
> >
> >The following patches convert offenders which were found by grep'ing the 
> >source
> >tree.
> 
> Looks like a good change to me.
> 
> Nitpick, do you need 11 patches to do it? 1 would be fine, I think?

I don't. I just got carried away with Mercurial's patch queues support.

Josef 'Jeff' Sipek.

-- 
A computer without Microsoft is like chocolate cake without mustard.
