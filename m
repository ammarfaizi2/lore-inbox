Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUGOCqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUGOCqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGOCqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:46:52 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:32230 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S265789AbUGOCqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:46:48 -0400
Date: Wed, 14 Jul 2004 19:44:14 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Ricky Beam <jfbeam@bluetronic.net>,
       "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
Message-ID: <20040715024414.GG28239@ca-server1.us.oracle.com>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Jeff Garzik <jgarzik@pobox.com>, Ricky Beam <jfbeam@bluetronic.net>,
	"Eric D. Mudama" <edmudama@bounceswoosh.org>,
	"Robert M. Stockmann" <stock@stokkie.net>,
	linux-kernel@vger.kernel.org
References: <20040713064645.GA1660@bounceswoosh.org> <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net> <20040713164911.GA947@havoc.gtf.org> <20040713223541.GB7980@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713223541.GB7980@taniwha.stupidest.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 03:35:41PM -0700, Chris Wedgwood wrote:
> initrd is such a PITA at times, I wondered about something hacky like
> sticking LABEL parsing for rootfs (marked init) into the kernel but
> it's really gross.
> 
> Ideally the initrd/initramfs process just needs better (userspace)
> infrastructure to make it more reliable/easier.

	I'm waiting for udev to give me consistent device names easily.
Then I can specify root=/dev/disk1 and not have to scan-all-100-disks
for LABEL mounts.

Joel

-- 

	f/8 and be there.

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
