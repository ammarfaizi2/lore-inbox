Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271337AbTG2Hxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271341AbTG2Hx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:53:29 -0400
Received: from luli.rootdir.de ([213.133.108.222]:42707 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S271337AbTG2HxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:53:24 -0400
Date: Tue, 29 Jul 2003 09:53:07 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030729075307.GA914@rootdir.de>
References: <20030728210910.GA832@rootdir.de> <20030728225838.GA1845@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728225838.GA1845@win.tue.nl>
Reply-By: Fre Aug  1 09:50:27 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test1-ac3 i686
X-No-archive: yes
X-Uptime: 09:50:27 up 1 min,  2 users,  load average: 1.12, 0.30, 0.10
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!



> [It would also be nice to see a log where things failed.
> Probably syslog would still work.]

I cannot reproduce the error any more :(
It seems to work now. But dont ask my why.


> So far the story of your debug file.
> What is your actual hardware? Is there a mouse?

There is no PS/2 mouse. There is only the Keytronic KT-452
keyboard. Its about 14 years old and its switchable between
AT and XT. And it has a DIN-Plug. I am using an adaptor.
I just opend it and now i write you the chips inside it:

K450A/452A R.O.C.
PCB NO.P1.810133.01
EIC-8 94HB

big chip:
1. COPAM-8649B
   2204R14 9018KE
   SCN8049H
   (c) Intel 1977
   (m) signetics
   
smaller chips:
2. TI 035 CS
   SN74LS125AN
   MALAYSIA
   
3. 74LS138N
   2103J30
   9018EG

The other keyboard that always worked has this chip inside:
   P8052AH 9706
   9419
   STC-02A
   INTEL (c) 1980


-- claas
