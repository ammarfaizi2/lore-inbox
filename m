Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWJASZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWJASZA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWJASY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:24:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:23004 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751247AbWJASY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:24:58 -0400
Message-Id: <1159727100.17934.272276407@webmail.messagingengine.com>
X-Sasl-Enc: wgx4VmYsEcq7zHlZe0erl7fNu2/kxiD8Ba0k8DOSayCj 1159727100
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
   <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
   <451FC7DC.7070909@s5r6.in-berlin.de>
   <200610011605.k91G5wJD031632@turing-police.cc.vt.edu>
   <20061001094342.55a331d1.rdunlap@xenotime.net>
   <1159723673.14141.272274719@webmail.messagingengine.com>
   <653402b90610011052o24574dd5o4cb911f118e8adfd@mail.gmail.com>
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
In-Reply-To: <653402b90610011052o24574dd5o4cb911f118e8adfd@mail.gmail.com>
Date: Sun, 01 Oct 2006 20:25:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 19:52:35 +0200, "Miguel Ojeda" <maxextreme@gmail.com>
said:
> On 10/1/06, Alexander van Heukelum <heukelum@fastmail.fm> wrote:
> > I think there is a problem with the name anyhow. Would you use the
> > LCD(d)isplay driver for an OLED screen?
> >
> > How about auxiliary display or AUXdisplay?
> >
> > Alexander
> >
> 
> Mi first guess was drivers/display/, to put driver about
> extra-displays, not only LCDs.
> 
> But people thought it can confuse users, so I chose to add "LCD" to be
> more specific.
> 
> And no, it is not an organic screen. It is for a cfag12864b LCD
> (Liquid Crystal Display):
> 
> http://www.crystalfontz.com/products/12864b/index.html

Ah, I should have read the whole thread before replying. I have not 
read the code, but... In your original mail you mention it adds a 
new "lcddisplay" class. I think this wants to be called "auxdisplay".

For the device drivers, you could just use either the acronym alone or
write it out, i.e., just use: cfag12864b Liquid Crystal Display driver, 
or (as stolen from that url) CFAG12864B Series Standard Graphic LCD 
driver.

Good luck,
Alexander
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free

