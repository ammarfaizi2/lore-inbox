Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVFGCk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVFGCk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVFGCk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:40:59 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:64935 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261429AbVFGCky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:40:54 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.12-rc6 mouse wheel not working
Date: Mon, 6 Jun 2005 21:40:48 -0500
User-Agent: KMail/1.8.1
Cc: "Steve Lee" <steve@tuxsoft.com>
References: <20050607011247.OLDV20878.lakermmtao04.cox.net@saturn>
In-Reply-To: <20050607011247.OLDV20878.lakermmtao04.cox.net@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506062140.48723.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 20:11, Steve Lee wrote:
> I've been using 2.6.11.11 just fine, but I thought I'd give 2.6.12-rc6 a
> test run.  With 2.6.11.11, my mouse works as expected (wheel works fine),
> however, 2.6.12-rc6 this is not true.  I saw there were some changes with
> regards to the mouse, and it's apparent these changes have affected my
> system in a negative way.  I have the Logitech MX 1000 connected to a Belkin
> OnmiCube switch via PS2.  Please CC me as I'm not a subscriber to this list.
> I'd be more than happy to test any possible fixes.  Oh, this is on a Linux
> From Scratch 6.0 (w/BLFS updates) system with dual athlon MPs.
>

Is there a difference in how kernel identifies your mouse? MX 1000-specific
support was introduced in 2.6.12...  

Does it help if you revert the following patch:

http://linux.bkbits.net:8080/linux-2.5/gnupatch%4042038820Zbz0cXacn-y2xfuPP_JqIw
 
-- 
Dmitry
