Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUD2GYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUD2GYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUD2GYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:24:45 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:6032 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263555AbUD2GYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:24:44 -0400
Date: Wed, 28 Apr 2004 23:24:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jens Axboe <axboe@suse.de>
Cc: Kenneth Johansson <ken@kenjo.org>,
       Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Message-ID: <20040429062436.GA6507@taniwha.stupidest.org>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de> <8n23m1-g22.ln1@legolas.mmuehlenhoff.de> <20040428113056.GA2150@suse.de> <1083176956.2679.19.camel@tiger> <20040428200953.GA3470@suse.de> <20040428221334.GA22404@taniwha.stupidest.org> <20040429061956.GA3558@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429061956.GA3558@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 08:19:58AM +0200, Jens Axboe wrote:

> Yeah, with 'retries' I mean waiting retries. The command does expire
> and ide-cd notices it just doesn't put an upper bound on how long it
> waits.  A minute or so should suffice, unless the caller specifies
> otherwise.

Can we poke the IDE drive is it's hung or reset it in these cases?  I
wonder more in the general case where I've had to reboot because the
burner went nuts for some reason...

  --cw
