Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRLNXvH>; Fri, 14 Dec 2001 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRLNXu7>; Fri, 14 Dec 2001 18:50:59 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:63248 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S280960AbRLNXur>; Fri, 14 Dec 2001 18:50:47 -0500
Date: Sat, 15 Dec 2001 00:50:44 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems downgrading from Kernel 2.4.8 to 2.2.20
Message-ID: <20011214235044.GB29591@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1008372849.273.8.camel@PC2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1008372849.273.8.camel@PC2>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, jlm wrote:

> I am trying to downgrade, to see if an issue with the 2.4.x series
> kernel is also present in the 2.2.x series. I have successfully
> downloaded, compiled and installed a 2.2.20 kernel and added the
> necessary lines to lilo in order to have it as an option and to boot
> into the same root partition as the 2.4.8 uses.
> 
> I am getting an error when I boot up 2.2.20. Right after the partition
> check it says this:
> Invalid session number or type of track

Now that looks strange. Show some context around this line.

> hda: lost interrupt

That looks stranger. I'd suggest to try Andre's IDE patch from any
kernel.org mirror, /pub/linux/kernel/people/hedrick, but it seems
there's no 2.2.20 ide patch yet.
