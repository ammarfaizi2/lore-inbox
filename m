Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSGLStb>; Fri, 12 Jul 2002 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSGLStZ>; Fri, 12 Jul 2002 14:49:25 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:52923 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S316705AbSGLStA>; Fri, 12 Jul 2002 14:49:00 -0400
Date: Fri, 12 Jul 2002 21:55:22 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI + cdwriter problem
Message-ID: <20020712185522.GA12751@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
References: <002d01c22882$f17436e0$0501a8c0@Stev.org> <E17ScQK-0000ih-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17ScQK-0000ih-00@the-village.bc.nu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 12:47:52PM +0100, Alan Cox wrote:
> > i also have now tried this under 2.4.19-rc1 which produces the same
> > problems.
> 
> Apply the diff below then retry. Let people know if it fixes your atapi 
> problem

Didn't fix mine either. First CD I tried to write on a pdc20265, I just
got these two messages in kern.log:

ide-scsi: CoD != 0 in idescsi_pc_intr
hdg: ATAPI reset complete

Too bad Burn-proof can't handle ATAPI resets...
