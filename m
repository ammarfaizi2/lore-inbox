Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUCJWRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbUCJWRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:17:43 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:17868 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262859AbUCJWRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:17:40 -0500
Date: Wed, 10 Mar 2004 23:17:40 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040310221740.GA7357@wohnheim.fh-wedel.de>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <20040310213427.GB7341@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040310213427.GB7341@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 March 2004 21:34:27 +0000, Jamie Lokier wrote:
> 
> I like the idea!

Thanks!

> I keep many hard-linked kernel trees, and local version management is
> done by "cp -rl" to make new trees and then change a few files in
> those trees, compile, test etc.  To prevent changes in one tree
> accidentally affecting other trees, I "chmod -R a-r" all but the tree
> I'm currently working on.
> 
> Thats works quite nicely, but it'd be even nicer to not need the
> "chmod", and just be confident that writes won't clobber files in
> another tree by accident.

Same here, that was my main motivation.  Ultimately I'd like to see a
lot of SCM functionality inside regular filesystems and this is just
the first step.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
