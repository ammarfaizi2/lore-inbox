Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUHDMjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUHDMjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHDMjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:39:07 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:21628 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262406AbUHDMi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:38:59 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: KVM & mouse wheel
Date: Wed, 4 Aug 2004 07:38:55 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Marko Macek <Marko.Macek@gmx.net>,
       Jesper Juhl <juhl-lkml@dif.dk>, Eric Wong <eric@yhbt.net>
References: <410FAE9B.5010909@gmx.net> <200408040025.20118.dtor_core@ameritech.net> <20040804071842.GA705@ucw.cz>
In-Reply-To: <20040804071842.GA705@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040738.55330.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 02:18 am, Vojtech Pavlik wrote:
> On Wed, Aug 04, 2004 at 12:25:19AM -0500, Dmitry Torokhov wrote:
> 
> > On Tuesday 03 August 2004 11:29 pm, Marko Macek wrote:
> > > Jesper Juhl wrote:
> > > 
> > > > <>I also had problems with my KVM switch and mouse when I initially 
> > > > moved to
> > > > 2.6, but adding this kernel boot parameter fixed it, meybe it will help
> > > > you as well : psmouse.proto=imps
> > > 
> > > This doesn't help. Only the patch I sent helps me. The problem is that the
> > > even with psmouse.proto=imps or exps, the driver still probes for 
> > > synaptics which I
> > > consider a bug.
> > > 
> > 
> > No it is not - Synaptics with a track-point on a passthrough port will have
> > track-point disabled if it is not reset after probing for imps/exps.
>  
> Hmm, does the imps/exps probe succeed in this case?
> 

No, it does not, at least not mine. It either does bare PS/2 or native, but
there are other Synaptics touchpads that can also do imps.

-- 
Dmitry
