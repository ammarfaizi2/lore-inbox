Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWFRSuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWFRSuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWFRSuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:50:51 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:48606 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932283AbWFRSuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:50:50 -0400
Message-ID: <4495A0A8.3080607@keyaccess.nl>
Date: Sun, 18 Jun 2006 20:51:20 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: Driver model ISA bus
References: <4485F97A.6020205@keyaccess.nl> <20060616234218.GC25127@kroah.com>
In-Reply-To: <20060616234218.GC25127@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Sorry for the delay.  It looks great to me so I've added it to my
> tree and will push it upstream when I can.

Okay, lovely, thanks.

Takashi: I'll be converting ALSA ISA drivers over to this now. What I'd 
in fact would like to do is do that one driver at a time. I have a 
metric buttload of these old ISA soundcards and believe it would be a 
nice opportunity to actually test these old drivers (and possibly do 
some cleanups) as I go along. Would you mind that?

If you'd rather the isa_bus thing was one discrete change, that's also 
okay though. I'd then just do that as a somewhat mechanical change and 
then revisit those drivers at some later time for additional testing 
and/or cleanup.

In either case, I'll ofcourse not submit anything untill this thing has 
made -mm.

Rene.

