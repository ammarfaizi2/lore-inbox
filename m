Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTF1OTn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 10:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTF1OTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 10:19:42 -0400
Received: from holomorphy.com ([66.224.33.161]:17304 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265248AbTF1OTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 10:19:41 -0400
Date: Sat, 28 Jun 2003 07:33:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Szonyi Calin <sony@etc.utt.ro>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mjb2
Message-ID: <20030628143343.GX26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Szonyi Calin <sony@etc.utt.ro>, linux-kernel@vger.kernel.org
References: <36540000.1056736708@[10.10.2.4]> <39714.194.138.39.55.1056809147.squirrel@webmail.etc.utt.ro> <43530000.1056809425@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43530000.1056809425@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Szonyi Calin <sony@etc.utt.ro> wrote:
>> I tested 2.5.72-mjb2 but it was full of oopses and crashes on my Duron
>> so I thought this patch is only for NUMA stuff.

On Sat, Jun 28, 2003 at 07:10:26AM -0700, Martin J. Bligh wrote:
> Nope, it should work with any machine  - you got the oopses?
> If you have an old distro with glibc < 2.3.1, Bill thinks the upside_down
> trick doesn't work because of some invalid assumptions glibc is making.
> If that's the case, could you check that 2.5.73-mjb1 works OK?

If this is causing too much confusion and/or other anguish I can live
with it getting withdrawn and keep it rolling in the ultra-experimental
section (-wli).

Alternatively, it should be trivial to convert to a config option that's
off by default.


-- wli
