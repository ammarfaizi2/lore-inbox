Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270292AbRHHDc1>; Tue, 7 Aug 2001 23:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270293AbRHHDcR>; Tue, 7 Aug 2001 23:32:17 -0400
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:15803 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270292AbRHHDcQ>; Tue, 7 Aug 2001 23:32:16 -0400
From: Josh McKinney <forming@home.com>
Date: Tue, 7 Aug 2001 22:32:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac9
Message-ID: <20010807223218.A6755@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <20010807235302.A16178@lightning.swansea.linux.org.uk> <Pine.LNX.4.33L.0108072218370.17803-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108072218370.17803-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Tue, Aug 07, 2001 at 10:55:01PM -0300, Rik van Riel wrote:
> On Tue, 7 Aug 2001, Alan Cox wrote:
> 
> > 2.4.7-ac9
> 
> > o	Allow swap < 2*ram				(Rik van Riel)
> 
> ... which I have verified to be functional, on SMP,
> but still isn't fine-tuned.
> 
> It would be cool if people with smallish swap areas
> could test this patch to see if any extra tuning would
> be needed.
> 
> regards,


>From my smallish tests with ac9 it works quite well.  I
have 256M of ram and I set 120M swap.  Then opened up 
about 30 mozilla windows, compiled several kernels at
once, gimp etc.  Swap went to zero and mem just hovered
at about 3056K free, but still useable and able to kill
of processes and bring it back.
