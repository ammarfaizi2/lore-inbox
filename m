Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBNKvF>; Wed, 14 Feb 2001 05:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129687AbRBNKuz>; Wed, 14 Feb 2001 05:50:55 -0500
Received: from mail.zmailer.org ([194.252.70.162]:53516 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129057AbRBNKul>;
	Wed, 14 Feb 2001 05:50:41 -0500
Date: Wed, 14 Feb 2001 12:50:27 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-kernel traffic statistics
Message-ID: <20010214125027.X15688@mea-ext.zmailer.org>
In-Reply-To: <20010214113107.W15688@mea-ext.zmailer.org> <200102140950.KAA10814@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102140950.KAA10814@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Wed, Feb 14, 2001 at 10:50:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 10:50:11AM +0100, Rogier Wolff wrote:
> Matti Aarnio wrote:
> > 	That  X-Mailing-List:  is actually a LOOP detection measure.
> > 	http://vger.kernel.org/lkml/#s3-9
> 
> Hi Matti,
> 
> May I ask you some statistics?
> How many people are on lkml? 

	3027 subscribers

	2481 separate domains.

> How many mails does vger send out every day on average? (I know it
> gets help from exploaders around the globe, so it probably doesn't add
> up to nmessages*nsubscribers).

	It used to get help from fanout servers, none are in use anymore.
	Vger's load-average is around 0.0 - 0.1, nevertheless ;)

	Picking one address only present at linux-kernel, and counting
	some days backwards with logs (these include also retries,
	which often to the choses sample destination are 0):

/var/log/maillog.1
    232
/var/log/maillog.2
    259
/var/log/maillog.3
    139
/var/log/maillog.4
    102
/var/log/maillog.5
    148
/var/log/maillog.6
    216
/var/log/maillog.7
    240

	So, 100 to 260 messages per day during the past week of rotated
	logs.

	Total daily traffic counts of successfull sends are:
	(Each recipient address, not only domain, gets its own syslog line)

/var/log/maillog.1
 719616
/var/log/maillog.2
 812118
/var/log/maillog.3
 429046
/var/log/maillog.4
 316667
/var/log/maillog.5
 460353
/var/log/maillog.6
 669020
/var/log/maillog.7
 752678

	And the grand-totals of SMTP delivery attempts:

/var/log/maillog.1
 725514
/var/log/maillog.2
 821661
/var/log/maillog.3
 438685
/var/log/maillog.4
 322529
/var/log/maillog.5
 466632
/var/log/maillog.6
 676869
/var/log/maillog.7
 757461


	So, yesterday  linux-kernel traffic represented 97.6% of all
	traffic at VGER.  On day number 4 - also 97.5% ...

	The share of failed delivery attempts (retries, etc) hovers
	around 1-2 percent of all.
	(I did spot calculations, others may want to do some
	 spread-sheeting.)

> 			Roger. 
> -- 
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **

/Matti Aarnio
