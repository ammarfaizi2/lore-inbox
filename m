Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267256AbUHDFZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbUHDFZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUHDFZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:25:30 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:40564 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267256AbUHDFZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:25:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: KVM & mouse wheel
Date: Wed, 4 Aug 2004 00:25:19 -0500
User-Agent: KMail/1.6.2
Cc: Marko Macek <Marko.Macek@gmx.net>, Jesper Juhl <juhl-lkml@dif.dk>,
       Vojtech Pavlik <vojtech@suse.cz>, Eric Wong <eric@yhbt.net>
References: <410FAE9B.5010909@gmx.net> <Pine.LNX.4.60.0408032257250.2821@dragon.hygekrogen.localhost> <4110660D.5050003@gmx.net>
In-Reply-To: <4110660D.5050003@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040025.20118.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 11:29 pm, Marko Macek wrote:
> Jesper Juhl wrote:
> 
> > <>I also had problems with my KVM switch and mouse when I initially 
> > moved to
> > 2.6, but adding this kernel boot parameter fixed it, meybe it will help
> > you as well : psmouse.proto=imps
> 
> This doesn't help. Only the patch I sent helps me. The problem is that the
> even with psmouse.proto=imps or exps, the driver still probes for 
> synaptics which I
> consider a bug.
> 

No it is not - Synaptics with a track-point on a passthrough port will have
track-point disabled if it is not reset after probing for imps/exps.

-- 
Dmitry
