Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264710AbUFGOrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbUFGOrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264720AbUFGOrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:47:19 -0400
Received: from mail.scienion.de ([141.16.81.54]:8935 "EHLO
	server03.hq.scienion.de") by vger.kernel.org with ESMTP
	id S264710AbUFGOrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:47:13 -0400
Message-ID: <40C47FEE.6080505@scienion.de>
Date: Mon, 07 Jun 2004 16:47:10 +0200
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Duthie <psycho@albatross.co.nz>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz>
X-MIMETrack: Itemize by SMTP Server on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 16:56:13,
	Serialize by Router on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 16:56:15,
	Serialize complete at 07.06.2004 16:56:15
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Thanks ...

  The pure ALSA system with PCI Cirrus Logic CS4281
  (my configuration) just dropped of my list of
  the 'bad' one ....

  Does this bug freeze the machine ? Or just block
  the outputting program ?

  PCM will be the next to look at...

  +-compile->reboot->check->-+
  ^                          |
  |                          |
  +---<----------------------+

  Kind of feel like in the old days where
  a decend 'printf(stderr,....)' was THE
  state of the art debugging tool ....

  Cheers

  S.,

Keith Duthie wrote:
> On Mon, 7 Jun 2004, Sebastian Kloska wrote:
> 
> 
>>  So if anybody out there could give me guidance on how the apm code
>>  might interact with the ALSA sound system it would be highly
>>  appreciated....
> 
> 
> In a word, badly. For at least one chipset, suspending while outputting
> to the pcm device causes the program outputting to the pcm device to enter
> the uninterruptible sleep state. A reboot is then required for the pcm
> device to be usable again...
> 
> (I attempted to report this back in February, but my bug report and
> workaround patch apparently didn't get through the alsa-devel spam
> filters.)


-- 
**********************************
Dr. Sebastian Kloska
Head of Bioinformatics
Scienion AG
Volmerstr. 7a
12489 Berlin
phone: +49-(30)-6392-1708
fax:   +49-(30)-6392-1701
http://www.scienion.de
**********************************
