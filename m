Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTDPWSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbTDPWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:18:40 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:53396 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S261533AbTDPWSj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:18:39 -0400
Date: Thu, 17 Apr 2003 00:30:31 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Steve Kinneberg <kinnebergsteve@acmsystems.com>
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Linux1394dev <linux1394-devel@lists.sourceforge.net>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030417003031.2b603167.philippe.gramoulle@mmania.com>
In-Reply-To: <1050514375.589.1843.camel@stevek>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
	<20030416004933.GI16706@phunnypharm.org>
	<20030416184528.19c20372.philippe.gramoulle@mmania.com>
	<1050514375.589.1843.camel@stevek>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On 16 Apr 2003 10:32:54 -0700
Steve Kinneberg <kinnebergsteve@acmsystems.com> wrote:

  | On Wed, 2003-04-16 at 09:45, Philippe Gramoullé wrote:
  | > 
  | > # dmesg
  | > oot is not IRM capable, resetting...
  | > ieee1394: Remote root is not IRM capable, resetting...
  | > ieee1394: Remote root is not IRM capable, resetting...
  | > ieee1394: Remote root is not IRM capable, resetting...
  | > [message repeated 178 times and as long as the DV Camcorder in turned on]
  | 
  | I realize this isn't the problem you're really concerned about, but the
  | above may happen if you are using a version of the 1394 code off the
  | linux-2.4 branch prior to the patch I sent to the list Monday that Ben
  | recently applied.  (You should be able to get around this without
  | downloading the latest code and recompiling by setting attempt_root=1
  | when insmodding ohci1394.

Thanks for the tip. Anyway, for me 2.4 is no problem. Looking through the archives i saw that checking not the latest
code worked for me(tm) but this was some time ago and things may have changed ( i.e latest 2.4
code works as expected)

For 2.5, the thing is i remember being able to successfully use my DV Camcorder 
Canon Optura 200MC ( MVX2i in Europe) with IEEE1394 , around 2.5.59 IIRC.

Since then, i only got these "reset storms" versions over versions. Not that i complain about
but it's just that i hope that reporting bugs will be helpful to IEEE1394 developers, because
if it worked once,  then i don't see why i wouldn't work either with newer versions 8)

The goal for me is to switch asap to 2.5 as i see much improvements in my day to day
desktop use.

Thanks,

Philippe
