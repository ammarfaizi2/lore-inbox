Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUALXIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUALXIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:08:11 -0500
Received: from smtp09.auna.com ([62.81.186.19]:6636 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262308AbUALXII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:08:08 -0500
Date: Tue, 13 Jan 2004 00:08:05 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040112230805.GA3049@werewolf.able.es>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <20040109033655.GK11065@ca-server1.us.oracle.com> <87wu81tptc.fsf@bytesex.org> <20040112171656.GM11065@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040112171656.GM11065@ca-server1.us.oracle.com> (from Joel.Becker@oracle.com on Mon, Jan 12, 2004 at 18:16:56 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12, Joel Becker wrote:
> On Fri, Jan 09, 2004 at 10:49:03AM +0100, Gerd Knorr wrote:
> > I also think you don't need *all* minors for removable media.  I
> > havn't seen removable media with extended partitions so far.  IIRC zip
> > floppys are using /dev/sda4 and most other ones either /dev/sda1 or
> > /dev/sda directly, so we likely can catch 99% with just three device
> > nodes.
> 
> 	Ahh, but that's magic, and we don't want magic.  Today, you just
> 'magically' know that your camera card reader shows up at sda1.  We

Or that a standard MacOS hfs+ drive (or usb flash) does not show at sdc9
(as it does, in fact...).

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
