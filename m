Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274530AbRITO4q>; Thu, 20 Sep 2001 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274531AbRITO4g>; Thu, 20 Sep 2001 10:56:36 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:51474 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S274530AbRITO4c>; Thu, 20 Sep 2001 10:56:32 -0400
Message-ID: <3BAA0465.C02DFEB7@cyclades.com>
Date: Thu, 20 Sep 2001 11:59:49 -0300
From: "Daniela P. R. Magri Squassoni" <daniela@cyclades.com>
Organization: Cyclades
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: New generic HDLC available
In-Reply-To: <m3bsoumbtv.fsf@intrepid.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there any news about the inclusion of these changes in the kernel?

Best regards,

Daniela

Krzysztof Halasa wrote:
> 
> Hi,
> 
> I've put new experimental version of my generic HDLC code on
> http://hq.pm.waw.pl/hdlc/ ( ftp://ftp.pm.waw.pl/pub/linux/hdlc/experimental/ )
> 
> Currently supported (hw drivers) are C101 and N2 (untested) boards.
> Protocols supported:
> - X.25 and PPP (via X.25 and syncppp routines)
> - Frame Relay (CCITT and ANSI LMI, or no LMI)
> - Cisco HDLC
> - raw HDLC (you can select NRZ/NRZI/Manchester/FM codes and parity)
> 
> This version uses new ioctl interface. Comments welcome.
> 
> No HDLC/FR bridging code yet. No Cisco LMI support (for FR) yet.
> No docs (except Documentation/networking/generic-hdlc.txt) yet.
> I'm thinking about implementing asynchronous HDLC driver.
> 
> The patch has been generated against 2.4.4-ac6 tree. It should apply to
> pure 2.4.4 as well. Protocol support is now split into separate files
> hdlc_fr.c, hdlc_cisco.c etc.
> --
> Krzysztof Halasa
> Network Administrator

-- 
________________________________________________

 Daniela P. R. M. Squassoni
     Software Engineer
  
 mailto:daniela@cyclades.com

 Cyclades Corporation - http://www.cyclades.com
________________________________________________
