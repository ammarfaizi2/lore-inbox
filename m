Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVIEDS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVIEDS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVIEDS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:18:29 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:9665 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932183AbVIEDS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:18:28 -0400
Date: Sun, 4 Sep 2005 23:18:25 -0400
To: Bret Towe <magnade@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
Message-ID: <20050905031825.GA22209@fieldses.org>
References: <dda83e78050903171516948181@mail.gmail.com> <dda83e7805090320053b03615d@mail.gmail.com> <20050904103523.GA5613@electric-eye.fr.zoreil.com> <dda83e78050904124454fc675a@mail.gmail.com> <dda83e78050904135113b95c4a@mail.gmail.com> <20050904215219.GA9812@fieldses.org> <dda83e780509042008294fbe26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda83e780509042008294fbe26@mail.gmail.com>
User-Agent: Mutt/1.5.10i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 08:08:22PM -0700, Bret Towe wrote:
> On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> > Do you get anything from alt-sysrq-T?
> 
> no i havent used that im usally in x when its freezing
> x wont even switch to console would it still give me anything then?

Well, you can try something like:
	alt-sysrq-T
wait a couple seconds, then
	alt-sysrq-S
	alt-sysrq-U
	alt-sysrq-B
with maybe a second between each to give stuff a chance to get to disk.

Then if you're lucky you may find the stack dumps in your log after you
reboot.

--b.
