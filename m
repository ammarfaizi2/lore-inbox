Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUF3UKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUF3UKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUF3UJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:09:11 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:19105 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262329AbUF3UIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:08:04 -0400
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 30 Jun 2004 20:06:42 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: twl@mail.com
To: "Dmitry Torokhov" <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 30 Jun 2004 15:08:02 -0500
Subject: RE: 2.6.7 oops in psmouse/serio while booting
X-Originating-Ip: 170.215.214.43
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20040630200802.860244BDAE@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, it seemd that your BIOS having some issues with USB legacy 
> emulation (oh-so-common-story). Could you please try compiling 
> psmouse as a module and load it _after_ all yur USB modules. 
> Does it get rid of phanthom mouse? If it does could you please 
> CC LKML so that the interested parties will know that the mistery 
> has been resolved? ;) 
>  
> -- 
> Dmitry 
>  
 
Yes, that did the trick.  The phantom PS/2 mouse is gone.  And I can still use 
either a USB mouse or a PS/2 mouse.  (It even boots a couple of seconds faster 
without the inital probe for the PS/2 mouse). 
 
Thanks. 
 
Tom 
 
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

