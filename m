Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVARMjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVARMjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVARMjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:39:39 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:64774 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261282AbVARMje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:39:34 -0500
Date: Tue, 18 Jan 2005 13:39:32 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, Andries Brouwer <aebr@win.tue.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118123932.GF8747@pclin040.win.tue.nl>
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet> <20050118105547.GD8747@pclin040.win.tue.nl> <20050118114701.GD2839@darkside.22.kls.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118114701.GD2839@darkside.22.kls.lan>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 12:47:01PM +0100, Mario Holbe wrote:

> > If you want to restore the device to full size, use
> > blockdev --setbsz 512.
> 
> Does that in any way hurt, if a filesystem is just mounted?

It is a bad idea to change the blocksize of a mounted filesystem.
