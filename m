Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271488AbSISP1V>; Thu, 19 Sep 2002 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271489AbSISP1V>; Thu, 19 Sep 2002 11:27:21 -0400
Received: from fermat.math.technion.ac.il ([132.68.115.6]:34439 "EHLO
	fermat.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S271488AbSISP1U>; Thu, 19 Sep 2002 11:27:20 -0400
Date: Thu, 19 Sep 2002 18:32:22 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: weird code (bug?) in IP options handling
Message-ID: <20020919153222.GB2762@fermat.math.technion.ac.il>
References: <20020919152801.GA2762@fermat.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919152801.GA2762@fermat.math.technion.ac.il>
User-Agent: Mutt/1.4i
Hebrew-Date: 14 Tishri 5763
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002, Nadav Har'El wrote about "weird code (bug?) in IP options handling":
> I am guessing that this is just a programming error, and the programmer
> perhaps intended to make the assignment in the inner for loop as
> 
> 	*optptr = IPOPT_END;

Oops, I meant something like

 	*optptr++ = IPOPT_END;

-- 
Nadav Har'El                        |    Thursday, Sep 19 2002, 14 Tishri 5763
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |"God is dead." - Nietzsche; "Nietzsche is
http://nadav.harel.org.il           |dead" - God
