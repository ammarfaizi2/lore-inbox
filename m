Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWAWPWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWAWPWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWAWPWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:22:19 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:36736 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751470AbWAWPWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SiPTVml2zS9hh5lC9uwhBpax8GJePua7GF/bVuCMKWaP1WyDrWUU8Bc9x0tHl5LhXZpYLmGewsOZkze/xMXPwl/crbsMuHZAA8TT65x8v48/TTTmtFx60Btwd2KgsqNPtBmbkmhUTX+42WIeD7p7BIHb0GLh/5mYLhyRg/T0N4E=
Message-ID: <9e4733910601230722k125f0391w74946b7401be85ce@mail.gmail.com>
Date: Mon, 23 Jan 2006 10:22:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
In-Reply-To: <9e4733910601220931x3a21e47dj7dbf834e2f36d31c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
	 <20060122142401.GA24738@SDF.LONESTAR.ORG>
	 <9e4733910601220931x3a21e47dj7dbf834e2f36d31c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I've asked the lighttpd people for more data but I haven't gotten
> anything back yet. Things like RAM, network speed, disk scheduler
> algorithm, etc.

The developer is using this hardware:
82541GI/PI Gigabit  ethernet
1.3Ghz Duron
7200RPM IDE disk
768MB RAM

Kernel:
2.6.13-1.1526_FC4
CFQ disk scheduler

Customer is getting same problem on highend hardware.

--
Jon Smirl
jonsmirl@gmail.com
