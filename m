Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTKPWVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 17:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKPWVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 17:21:07 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:44257 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263181AbTKPWVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 17:21:04 -0500
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
From: Will Dyson <will_dyson@pobox.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031116160958.GW30485@parcelfarce.linux.theplanet.co.uk>
References: <1068970562.19499.11.camel@thalience>
	 <20031116160958.GW30485@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1069021262.19499.55.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 17:21:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-16 at 11:09, Matthew Wilcox wrote:

> > -int match_int(substring_t *, int *result);
> > +int match_int(substring_t *s, int *result);
> 
> What value does this "s" add?  "result" is clearly useful documentation,
> but "s" says "There is no good name for this variable"

True, but that is what it is named in the function definition. I'll try
to think of a good name for these, but I guess a documentation patch is
not the place for that (since I'd want to change it in both declaration
and definition).

Your other comments are well-taken as well.

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

