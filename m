Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSKHLTc>; Fri, 8 Nov 2002 06:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSKHLTc>; Fri, 8 Nov 2002 06:19:32 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:44207 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261854AbSKHLTb>; Fri, 8 Nov 2002 06:19:31 -0500
Date: Fri, 8 Nov 2002 11:14:28 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021108111428.F628@nightmaster.csn.tu-chemnitz.de>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee> <20021108015316.GA1041@www.kroptech.com> <3DCB1D09.EE25507D@digeo.com> <20021108024905.GA10246@www.kroptech.com> <20021108080558.GR32005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021108080558.GR32005@suse.de>; from axboe@suse.de on Fri, Nov 08, 2002 at 09:05:58AM +0100
X-Spam-Score: -3.6 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18A7HA-0005Te-00*hktHtopVghw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, Nov 08, 2002 at 09:05:58AM +0100, Jens Axboe wrote:
> Ok I'm just about convinced now, I'll make 16 the default batch count.
> I'm very happy to hear that the deadline scheduler gets the job done
> there.

Isn't it exactly seek_cost, which you want?

Would you like to make it tunable from user space somehow?

Since Adam already noticed, that there might not be a "perfect"
value for all, this is the logical next step.

PS: If you update, please consider an update of your comments
   there, too ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
