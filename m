Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSF1Jar>; Fri, 28 Jun 2002 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSF1Jaq>; Fri, 28 Jun 2002 05:30:46 -0400
Received: from [62.70.58.70] ([62.70.58.70]:35204 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317083AbSF1Jap> convert rfc822-to-8bit;
	Fri, 28 Jun 2002 05:30:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Diego Calleja <diegocg@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] IDE error in (un)stable trees
Date: Fri, 28 Jun 2002 11:33:07 +0200
User-Agent: KMail/1.4.1
Cc: martin@daleki.de, Lionel.Bouton@inet6.fr
References: <20020627212843.3439f49e.diegocg@teleline.es>
In-Reply-To: <20020627212843.3439f49e.diegocg@teleline.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206281133.07157.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 June 2002 21:28, Diego Calleja wrote:
> I get this error message when I run hdparm -Y /dev/hda, And after this,
> I try to access some mounted partition:
<snip/>

from the hdparm manual

-Y   Force an IDE drive to immediately enter  the  lowest  power  consumption
      sleep mode, causing it to shut down completely.  A hard or soft reset is
      required before the drive can be accessed again (the  Linux  IDE  driver
      will  automatically handle issuing a reset if/when needed).  The current
      power mode status can be checked using the -C flag.

so - you need a hard or soft reset to go on ...

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

