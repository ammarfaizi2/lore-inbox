Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbRGEWn3>; Thu, 5 Jul 2001 18:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRGEWnT>; Thu, 5 Jul 2001 18:43:19 -0400
Received: from t2.redhat.com ([199.183.24.243]:1783 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265398AbRGEWnL>; Thu, 5 Jul 2001 18:43:11 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <0107060033180K.03760@starship> 
In-Reply-To: <0107060033180K.03760@starship>  <XFMail.20010705144521.davidel@xmailserver.org> 
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jul 2001 23:43:03 +0100
Message-ID: <9515.994372983@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


phillips@bonn-fries.net said:
> This program prints garbage:
> 	#define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x; })
> 	 	int main (void) { 
> 		int _x = 3, _y = 4; 
> 		printf("%i\n", min(_x, _y)); 
> 		return 0; 
> 	} 

Life's a bitch.
cf. get_user(__ret_gu, __val_gu); (on i386)

Time to invent a gcc extension which gives us unique names? :)

--
dwmw2


