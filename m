Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUFRUsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUFRUsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUFRUrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:47:53 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:51770 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262101AbUFRUp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:45:27 -0400
Date: Fri, 18 Jun 2004 22:56:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040618205602.GC4441@mars.ravnborg.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040617220651.0ceafa91.rddunlap@osdl.org> <20040618053455.GF29808@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618053455.GF29808@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 07:34:55AM +0200, Willy Tarreau wrote:
> On Thu, Jun 17, 2004 at 10:06:51PM -0700, Randy.Dunlap wrote:
> > 
> > Is this interesting to anyone besides me?
> > Save kernel version info when writing .config file.
> 
> Very good idea Randy ! I've already used some wrong config picked out of 20,
> and having a simple way to do a quick check is really an enhancement. BTW,
> does KERNELRELEASE include the build number ? and could we include the
> config date in the file too ?

Date seems worthwhile. buildnumber does not make sense since we do not
generate a new .config for each build.

	Sam
