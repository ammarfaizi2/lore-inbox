Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTGaUdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 16:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268822AbTGaUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 16:33:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39437
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S268702AbTGaUdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 16:33:11 -0400
Date: Thu, 31 Jul 2003 13:33:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm2
Message-ID: <20030731203309.GB970@matchmail.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030730223810.613755b4.akpm@osdl.org> <20030731193741.GA1618@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731193741.GA1618@home.woodlands>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 01:07:41AM +0530, Apurva Mehta wrote:
> However, when I did a `rpm --rebuilddb` on mm1 + O11int patches, I
> still got quite severe skipping toward the end of the 8 min process. I
> could not repeat the skipping again, even on the same kernel, because
> I guess there was not much rebuilding to do again..
> 
> If there are tools which I can use to produce helpful numbers, please
> let me know. I will post the required numbers ASAP. 

rpm is probably doing a lot of fsync() calls, so you'd want a benchmark that
did similar.  You'd get similar results from a mail server, or client
running on a bunch of messages too.
