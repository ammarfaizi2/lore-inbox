Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTBFXbY>; Thu, 6 Feb 2003 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTBFXbY>; Thu, 6 Feb 2003 18:31:24 -0500
Received: from relay-1m.club-internet.fr ([194.158.104.40]:2432 "HELO
	relay-1m.club-internet.fr") by vger.kernel.org with SMTP
	id <S267539AbTBFXbW> convert rfc822-to-8bit; Thu, 6 Feb 2003 18:31:22 -0500
Date: Fri, 7 Feb 2003 00:40:37 +0100
From: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: markh@osdl.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
Message-Id: <20030207004037.334abaaf.philippe.gramoulle@mmania.com>
In-Reply-To: <Pine.LNX.4.44.0302061202430.3545-100000@home.transmeta.com>
References: <1044559247.4858.49.camel@markh1.pdx.osdl.net>
	<Pine.LNX.4.44.0302061202430.3545-100000@home.transmeta.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.9claws41 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, i posted the fix on Feb 4th, but i forgot 
 1) to include [PATCH] in the subject and 2) to send it to the
right person instead of just posting to LKML, as it's my first post :o)

The fix was attached as well and shouldn't have whitespace<->tab issue

Thanks,

Philippe

--
Philippe Gramoullé
philippe.gramoulle@mmania.com
Lycos Europe - NOC France


On Thu, 6 Feb 2003 12:04:15 -0800 (PST)
Linus Torvalds <torvalds@transmeta.com> wrote:


  |  
  |  On 6 Feb 2003, Mark Haverkamp wrote:
  |  >
  |  > This moves access of the host element to device since host has been
  |  > removed from struct scsi_cmnd.
  |  
  |  This is whitespace-damaged.
  |  
  |  Please fix broken mailers. I generally don't bother to fix up whitespace
  |  damage from people who can't bother to have a good mailer. It's just not 
  |  worth it - if I try to fix it up (even if it is often trivial), it just 
  |  means that people will continue to send crap patches to me.
  |  
  |  		Linus
  |  
  |  -
  |  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
  |  the body of a message to majordomo@vger.kernel.org
  |  More majordomo info at  http://vger.kernel.org/majordomo-info.html
  |  Please read the FAQ at  http://www.tux.org/lkml/
  |  
