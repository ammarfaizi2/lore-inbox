Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUGBWu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUGBWu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUGBWu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:50:59 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:31882 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S265031AbUGBWu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:50:57 -0400
Date: Fri, 2 Jul 2004 18:50:58 -0400
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary database
Message-ID: <20040702225057.GH606@fieldses.org>
References: <Pine.LNX.4.44.0407021341280.27383-100000@kaki.stanford.edu> <Pine.LNX.4.44.0407021412080.27383-100000@kaki.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407021412080.27383-100000@kaki.stanford.edu>
User-Agent: Mutt/1.5.6+20040523i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 02:12:39PM -0700, Yichen Xie wrote:
> Yichen Xie <yxie@cs.stanford.edu> wrote:
> >
> > I will update the error reports when the results are ready. 
> 
> err2.html now updated. -yichen

Are you planning to run it on a more recent kernel too?  Some of the
nfsd reports clearly good finds (thanks, I'll make patches), but a lot
of them are in bits of the code that have changed recently (from a quick
check, I think that at least err1-32, err1-33, err1-42, from Andrew
Morton's list, have been fixed).

--Bruce Fields
