Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTH0LEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTH0LEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:04:43 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:57562 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263309AbTH0LEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:04:41 -0400
Date: Wed, 27 Aug 2003 14:04:17 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030827110417.GY83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org, tejun@aratech.co.kr
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827101313.GX83336@niksula.cs.hut.fi> <20030827125633.45f9a003.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827125633.45f9a003.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 12:56:33PM +0200, you [Stephan von Krawczynski] wrote:
> 
> > Or, did you use kdb/kgdb in addition to serial console?
> 
> No.
 
Ok. 

I might give a debugger a shot anyway when I find the time.

> You're right, it looks pretty clean and simple. Possibly the only thing I would
> try is moving aic away from int 9 to int 10 or so. Int 9 sometimes interferes
> with VGA int routing on broken boxes. But that is unlikely (though simple to
> test).

I don't think vga interferes with anything: I never run X on the box, and
even the text console remains quiescent as nothing is logged.

Better test would perhaps be to get rid of Adaptec 2940 altogether and move
the rootfs on an ide disk. But that's not exactly convenient either...


-- v --

v@iki.fi
