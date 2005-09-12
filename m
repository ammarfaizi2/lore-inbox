Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVILWrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVILWrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVILWrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:47:53 -0400
Received: from dvhart.com ([64.146.134.43]:61057 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932329AbVILWrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:47:52 -0400
Date: Mon, 12 Sep 2005 15:47:49 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Sonny Rao <sonny@burdell.org>, Danny ter Haar <dth@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
Message-ID: <211430000.1126565269@flay>
In-Reply-To: <20050912220617.GA18215@kevlar.burdell.org>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912145435.GA4722@kevlar.burdell.org> <20050912125641.4b53553d.akpm@osdl.org> <20050912200914.GA13962@kevlar.burdell.org> <dg4qeg$27m$1@news.cistron.nl> <20050912220617.GA18215@kevlar.burdell.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, September 12, 2005 18:06:17 -0400 Sonny Rao <sonny@burdell.org> wrote:

> On Mon, Sep 12, 2005 at 09:03:12PM +0000, Danny ter Haar wrote:
>> Sonny Rao  <sonny@burdell.org> wrote:
>> > I assume you're referring to allocating huge pages?  I'm not sure how
>> > one would test this other than allocating N huge pages, releasing,
>> > runing something intensive (like SDET), and then trying to allocate
>> > N huge pages again?  Or am I off base here?
>> 
>> Run a full-feed usenet server ? ;-)
>> I recommend INN ....
> 
> Are you using jumbo frames or anything like that?  I can probably
> replicate order > 0 allocation failures pretty easily using that, but
> I don't know if that's really the issue.

Jumbo frames, 8K kernel stacks, CIFS, and possibly NFS (though people dispute
that) tend to be the main culprits, in my experience.

M.

