Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288124AbSA0QvV>; Sun, 27 Jan 2002 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288248AbSA0QvM>; Sun, 27 Jan 2002 11:51:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21253 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288153AbSA0Qu7>;
	Sun, 27 Jan 2002 11:50:59 -0500
Message-ID: <3C542FE6.7C56D6BD@mandrakesoft.com>
Date: Sun, 27 Jan 2002 11:50:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C52E671.605FA2F3@mandrakesoft.com> <3C540A90.5020904@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> I would like to notice that the changes in 2.4.18-pre7 to the
> tulip eth driver are apparently causing absymal performance drops
> on my version of this card. Apparently the performance is dropping
> from the expected 10MB/s to about 10kB/s. The only special
> thing about the configuration in question is the fact that it's
> a direct connection between two hosts. Well, more precisely it's
> a cross-over link between my notebook and desktop.

Are you seeing collisions?
What is the other side configured as?
What type of cabling?


> Here is an excerpt from the lspci command:
> 
> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21041

This is interesting considering that for most people, 21041 did not work
at all until 2.4.18-preXX tulip patches.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
