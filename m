Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUGBXoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUGBXoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUGBXoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:44:10 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:10698 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S265101AbUGBXoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:44:07 -0400
Date: Fri, 2 Jul 2004 16:44:04 -0700 (PDT)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@kaki.stanford.edu
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
In-Reply-To: <20040702225057.GH606@fieldses.org>
Message-ID: <Pine.LNX.4.44.0407021638310.28513-100000@kaki.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruce, thanks for the feedback! I kept pounding on 2.6.5 (then current
branch when I got started) to be able to tune the tool on one single code
base. Once it gets stabalized I hope to be able to automate the run
process and run it on a regular basis on the latest trees. -yichen

On Fri, 2 Jul 2004, J. Bruce Fields wrote:

> On Fri, Jul 02, 2004 at 02:12:39PM -0700, Yichen Xie wrote:
> > Yichen Xie <yxie@cs.stanford.edu> wrote:
> > >
> > > I will update the error reports when the results are ready. 
> > 
> > err2.html now updated. -yichen
> 
> Are you planning to run it on a more recent kernel too?  Some of the
> nfsd reports clearly good finds (thanks, I'll make patches), but a lot
> of them are in bits of the code that have changed recently (from a quick
> check, I think that at least err1-32, err1-33, err1-42, from Andrew
> Morton's list, have been fixed).
> 
> --Bruce Fields
> 

