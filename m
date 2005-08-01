Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVHAOvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVHAOvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVHAOvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:51:53 -0400
Received: from styx.suse.cz ([82.119.242.94]:47069 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262104AbVHAOvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:51:52 -0400
Date: Mon, 1 Aug 2005 16:51:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lee Revell <rlrevell@joe-job.com>, abonilla@linuxwireless.org,
       linux-kernel@vger.kernel.org,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       Yani Ioannou <yani.ioannou@gmail.com>, Dave Hansen <dave@sr71.net>
Subject: Re: IBM HDAPS, I need a tip.
Message-ID: <20050801145151.GA26347@ucw.cz>
References: <1122861215.11148.26.camel@localhost.localdomain> <1122872189.5299.1.camel@localhost.localdomain> <1122873057.15825.26.camel@mindpipe> <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr> <42EE1324.10304@grupopie.com> <Pine.LNX.4.61.0508010836020.30161@chaos.analogic.com> <20050801130902.GA23949@ucw.cz> <Pine.LNX.4.61.0508011002070.30306@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508011002070.30306@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 10:22:57AM -0400, linux-os (Dick Johnson) wrote:

> Huh?  A laptop on the table is subjected to 1G on earth. If turned over,
> is still subjected to 1G, although the sensor may show -1G. Unless
> the correct k (calibration factor) is known, for each load direction,
> it cannot be derived from +/- 1, the only readings you have, because
> of the 1G bias of the load-cell itself.

The MEMS accelerometer measures the projection of the
acceleration/gravity vector in two orthogonal directions.

If you place the notebook on a horizontal table, the projection of
gravity to both the directions measured will be zero, because the
gravity vector is orthogonal to both of the directions.

Thus for each direction you get the value at -1, 0, and +1 G, and that's
perfectly enough to get a calibration, as long as the accelerometer is
linear, which MEMSes to a reasonable degree are.

> A pair of load-cells mounted orthagonally, will show the accelleration
> in 4 axis. However, you can't assume that if you held the mass at
> a 45 degree angle, for instance, that both sensors would read
> 0.707 (cos 45) or that if at 90, one pair would read 0.0

Well, accelerometers are not load cells with a weight mounted to them,
that's the thing.

> You need to calibrate using real values. With a sping-scale, and
> some room to swing the device, you can readily obtain some accurate
> load values.

The Earth's gravity is a very well known real value.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
