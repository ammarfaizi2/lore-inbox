Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269693AbUHZWt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269693AbUHZWt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHZWor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:44:47 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:40419 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S269688AbUHZWoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:44:20 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 22:44:10 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cglp3q$j75$1@news.cistron.nl>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com><45010000.1093553046@flay> <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org> <57730000.1093554054@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1093560250 19685 62.216.29.200 (26 Aug 2004 22:44:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <57730000.1093554054@flay>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
>> On Thu, 26 Aug 2004, Martin J. Bligh wrote:
>>> 
>>> What would "test -d" and "test -f" return on these magic beasties? I can't
>>> think of any combinations that wouldn't confuse the crap out of userspace.
>> 
>I think what you're saying is that they'd both return positive, right?

test -f file  -> true
test -f file/ -> false
test -d file  -> false
test -d file/ -> true

Mike.
-- 
"In times of universal deceit, telling the truth becomes
 a revolutionary act." -- George Orwell.

