Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278418AbRJMVlN>; Sat, 13 Oct 2001 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278417AbRJMVlE>; Sat, 13 Oct 2001 17:41:04 -0400
Received: from vitelus.com ([64.81.243.207]:56326 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278418AbRJMVkz>;
	Sat, 13 Oct 2001 17:40:55 -0400
Date: Sat, 13 Oct 2001 14:41:13 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Message-ID: <20011013144113.C9856@vitelus.com>
In-Reply-To: <20011013135507.B9856@vitelus.com> <Pine.LNX.3.96.1011013160400.28071B-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1011013160400.28071B-100000@mandrakesoft.mandrakesoft.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 04:06:18PM -0500, Jeff Garzik wrote:
> I am getting the same thing here.  I am using iptables 1.2.2 SRPMS from
> Mandrake 8.1, compiled against the latest 2.4 kernel.  Same message as
> in $subject.  I poked through the source and found that "module is wrong
> version" is the standard text message for the error code EINVAL, which
> is rather silly and uninformative.

I had the problem until I build iptables against my kernel
configuration.
