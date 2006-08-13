Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWHMNIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWHMNIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 09:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWHMNIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 09:08:23 -0400
Received: from smtp110.plus.mail.re2.yahoo.com ([206.190.53.35]:7082 "HELO
	smtp110.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751251AbWHMNIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 09:08:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pwpukKE3nXa1qXw6PoTWNTIZ3L+zHKJtKtsEl9lK0sFQkCLTTlZBbDKjZV1dch08dItuEgwUOoJ/PJD9x49wHagQNgGxgXnVcI+B/f6ZqO8lgH7iId/8fq8cnBT0drSFPIAcxxJ3X5cNzp1FQ/s5VQgjGZ8gJIcO9GRgAJPPb3g=  ;
Message-ID: <44DF2442.6050509@yahoo.es>
Date: Sun, 13 Aug 2006 15:08:18 +0200
From: Aurelio Arroyo <listas_sk3@yahoo.es>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
CC: linux-atm-general@lists.sourceforge.net, usbatm@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] [ATM CLIP][USBATM] Linux 2.6.16(13) to	2.6.17(4)
 migration problem
References: <NBBBIHMOBLOHKCGIMJMDMEOJFLAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDMEOJFLAA.g.tomassoni@libero.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni escribió:
> Dears,
>
> I have a couple of ADSL lines to Internet, connected to two linux boxes through a couple of SpeedTouch 330. One box adopts the Classical IP protocol, while the other the PPPoA one.
>
> Both the internet connections worked fine for month up to the 2.6.16.13 kernel. Now, upgrading to 2.6.17.4, things work fine for few seconds (a minute at most, but timing varies), then the box stops receiving packets. No event is logged, but I didn't manage to turn debugging log on.
>
> When things break, I can see that outgoing packets increse the tx field in /proc/net/atm/speedtch:0, while the rx field gets stuck.
>
> I can't set up a testbed for this, since I need to keep the two boxes running, nor I have handy a further SpeedTouch 330. Actually, I just stepped back the boxes to 2.6.16.13.
>
> However, before looking for another modem and managing to set up a third machine as a testbed, I would like to know if any of you has any experience to share about SpeedTouch or USBATM or ATM troubles with 2.6.17.x.
>
>   

Yes,
    http://bugzilla.kernel.org/show_bug.cgi?id=6752



		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com
