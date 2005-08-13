Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVHMQdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVHMQdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHMQdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:33:51 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:47735 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932184AbVHMQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:33:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=oFzgFcMZOQCuJQwXptLH54oqM6eN+tY1V6xh5iFKubVsD67s/MkQpDvIk2jGSETuRuGrd+Qyo08jxnFoLHDTmiAR3rz4KumceV+g1T+Xce+MpLzvtaWTQ40HNaFViSuy8E2H3aSfEolLA4o+dLIy/UO/OYDHnNlpyxZW37hB4Co=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Grant Coady <Grant.Coady@gmail.com>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Sat, 13 Aug 2005 18:34:16 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200508131710.38569.annabellesgarden@yahoo.de> <d86sf15b5b36ta7rgkjo2p980fku9e0lce@4ax.com>
In-Reply-To: <d86sf15b5b36ta7rgkjo2p980fku9e0lce@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508131834.16629.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 13. August 2005 18:04 schrieb Grant Coady:
> 
> I'm tracking a dataloss on box with this chip, finding it difficult 
> to nail a configuration that reliably produces dataloss, sometimes 
> only one bit (e.g. 'c' --> 'C') of unpacking kernel source tree gets 
> changed.
> 
> Relevant?  This is on a KM400 with Skt A Sempron + Seagate SATA HDD.
> http://bugsplatter.mine.nu/test/linux-2.6/sempro/

Very unlikely. Rare bitwise errors like yours are more likely caused by 
i.e. broken IDE cable or too fast an IDE-controller setting for the
cable / drive. Or memory error. Or an itch on the mainboard. or++

Interrupt errors would cause errors blockwisely.
like whole sectors of data missing, device not working....

   Karsten  

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
