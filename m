Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270729AbTGUVjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGUVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:39:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49300 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S270729AbTGUVjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:39:02 -0400
Date: Mon, 21 Jul 2003 17:55:51 -0400
From: Simon Boulet <simon.boulet@divahost.net>
Subject: Re: 2.6.0-test1+ Alsa + Intel 82801CA/CAM AC'97 Audio OOPS
In-reply-to: <"from tiwai"@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030721215551.GC1704@i2650>
MIME-version: 1.0
X-Mailer: Balsa 2.0.12
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20030719021012.GA919@i2650> <s5h4r1gj6t2.wl@alsa2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, CONFIG_FRAME_POINTER does fix my issues with ALSA. And the patch 
submited by Valdis some days ago fixed OSS.

Thank you

Simon

On 2003.07.21 10:25, Takashi Iwai wrote:
> At Fri, 18 Jul 2003 22:10:12 -0400,
> Simon Boulet wrote:
> >
> > [1  <text/plain; ISO-8859-1 (7bit)>]
> > Hello everyone,
> >
> > In case I am sending this to a list, please CC to me regarding
> anything
> > related to this issue. I am not a member of the list.
> >
> > I am having a Kernel OOPS with 2.6.0-test1-ac2 (same thing under
> non-
> > ac2) using ALSA with OSS compatibily enabled on an Intel 82801CA/
> CAM
> 
> > AC'97 (ICH3 mobile) integrated Audio.
> 
> perhaps a known problem.
> a workaround is to turn on the framepointer.
> 
> 
> Takashi
> 
> 
