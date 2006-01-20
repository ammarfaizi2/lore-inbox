Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWATDpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWATDpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 22:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWATDpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 22:45:06 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:30159 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1161115AbWATDpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 22:45:05 -0500
Message-ID: <43D05D0C.1030900@keyaccess.nl>
Date: Fri, 20 Jan 2006 04:46:20 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain>
In-Reply-To: <m3ek34vucz.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:

>> SOUND_ADLIB
> 
> IIRC 8-bit sound, ISA. GUS on DOS used to emulate it

Extremely classic card. Would be fun to still have around if only for 
history's sake...

>> SOUND_PAS
> 
> Pro Audio Spectrum. Earlier than GUS? 8-bit I think

Also drives my PAS16s. Yes, it's very old -- non-pnp ISA and all that. 
Used to be a fairly popular card at the time though (since it sounds 
better than most other cards of the era) so there's still a couple of 
those around. I believe I have three lying around somewhere, one of them 
in fact still installed (in a machine that's currently not available 
though).

Sure, wouldn't be a tragedy to remove, but keeping it neither (writing 
an ALSA driver for the stupid thing has been on my personal TODO only 
slightly shorter then all the items preceding it).

>> SOUND_PSS
>> SOUND_SB
> 
> The original one (8-bit)? Not sure about relation to Kahlua and PAS

The relation to PAS16 at least is that the PAS includes a (independent) 
SB8 compatible chip. The OSS driver supplies two sound devices. At the 
moment, I'm not recalling with certainty whether or not they were also 
hardware mixed, but I guess they were...

Rene.
