Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbTLIOcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbTLIOcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:32:23 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:64779 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265876AbTLIOcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:32:12 -0500
Date: Tue, 9 Dec 2003 14:34:12 +0000
From: Joe Thornber <thornber@sistina.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031209143412.GI472@reti>
References: <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 12:10:06PM -0200, Marcelo Tosatti wrote:
> 
> 
> On Tue, 9 Dec 2003, Joe Thornber wrote:
> 
> > On Tue, Dec 09, 2003 at 11:15:08AM -0200, Marcelo Tosatti wrote:
> > > I believe 2.6 is the right place for the device mapper. 
> > 
> > So what's the difference between a new filesystem like XFS and a new
> > device driver like dm ?
> 
> Expected question... 
> 
> XFS is a totally different filesystem from the ones present in 2.4. 
> 
> As far as I know, we already have the similar functionality in 2.4 with
> LVM. Device mapper provides the same functionality but in a much cleaner
> way. Is that right?

Sort of, but please take into account the fact that the LVM1 driver
has bugs (particularly on the failure paths), and EVMS and other
volume managers dont use the LVM1 driver.  The snapshot target (which
I didn't include in the core patches) is hugely better performance
wise.

- Joe
