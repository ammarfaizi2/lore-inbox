Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUHORqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUHORqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUHORqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:46:43 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:28290 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266708AbUHORqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:46:42 -0400
Date: Sun, 15 Aug 2004 19:49:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove obsolete HEAD in top Makefile
Message-ID: <20040815174915.GA7265@mars.ravnborg.org>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <411F3A48.2030201@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411F3A48.2030201@greatcn.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 06:26:16PM +0800, Coywolf Qi Hunt wrote:
> Hi,
> 
> This removes an obsolete variable in the top Makefile. It is used in 2.4 
> Makefile.
> Now the 2.6 kbuild is no longer using it. I have tested it.

find -name 'Makefile*' | xargs grep HEAD
identify one user: cris.

Please resend patch with removal in arch/cris/Makefile.

	Sam
