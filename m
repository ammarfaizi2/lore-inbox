Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTFQSEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTFQSEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:04:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13444 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264456AbTFQSEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:04:52 -0400
Subject: Re: 2.5.72 oops (scheduling while atomic)
From: Paul Larson <plars@linuxtestproject.org>
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, rml@tech9.net
In-Reply-To: <20030617143551.GA3057@glitch.localdomain>
References: <20030617143551.GA3057@glitch.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Jun 2003 13:17:54 -0500
Message-Id: <1055873875.948.13.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 09:35, Greg Norris wrote:
> I'm getting the following oops when booting 2.5.72, preceded by a
> quite a few "bad: scheduling while atomic!" messages.  My .config and
> the decoded oops are attached.
> 
> Any insights and/or suggestions would be appreciated.  Thanx!
I submitted a bug on this a while back, bug #800 in bugme:
http://bugme.osdl.org/show_bug.cgi?id=800

I saw it starting with 2.5.70-bk15.  It looks like it did not have this
problem in 2.5.70-bk14.  Does this seem to be the case with you as
well?  I have not yet had time to hunt down more than is in that bug
report.

Thanks,
Paul Larson


