Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSHGCBE>; Tue, 6 Aug 2002 22:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSHGCBE>; Tue, 6 Aug 2002 22:01:04 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:4147 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S317017AbSHGCBC>;
	Tue, 6 Aug 2002 22:01:02 -0400
From: <Hell.Surfers@cwctv.net>
To: niraj_gupta@imedia-tech.com, linux-kernel@vger.kernel.org
Date: Wed, 7 Aug 2002 03:04:27 +0100
Subject: RE:need serial tty driver help - implementing a new uart driver
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1028685867072"
Message-ID: <070c45903020782DTVMAIL10@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1028685867072
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Try looking at the basic serial driver @ linux/drivers/char, or something like that.



On 	Tue, 6 Aug 2002 18:50:02 -0700 	niraj gupta <niraj_gupta@imedia-tech.com> wrote:

--1028685867072
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Wed, 7 Aug 2002 02:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSHGBq3>; Tue, 6 Aug 2002 21:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSHGBq3>; Tue, 6 Aug 2002 21:46:29 -0400
Received: from oe-mp2pub.managedmail.com ([206.46.164.23]:33973 "EHLO
	oe-mp2.bizmailsrvcs.net") by vger.kernel.org with ESMTP
	id <S316675AbSHGBq3>; Tue, 6 Aug 2002 21:46:29 -0400
Received: from there ([66.14.75.66]) by oe-mp2.bizmailsrvcs.net
          (InterMail vM.5.01.03.15 201-253-122-118-115-20011108) with SMTP
          id <20020807015002.FBNL7965.oe-mp2.bizmailsrvcs.net@there>
          for <linux-kernel@vger.kernel.org>;
          Tue, 6 Aug 2002 20:50:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: niraj gupta <niraj_gupta@imedia-tech.com>
Organization: imedia-tech
To: linux-kernel@vger.kernel.org
Subject: need serial tty driver help - implementing a new uart driver
Date: Tue, 6 Aug 2002 18:50:02 -0700
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020807015002.FBNL7965.oe-mp2.bizmailsrvcs.net@there>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

hi

i am working on writing a serial - tty driver for a custom board
the uart in implemented in a fpga and has two very simple fifo's for rx/tx
and few bit on status of the fifo, masks for the interrupts. it is a
simple fixed baud rate bit blaster with three wire interface, i was looking
to see if there is an existing driver that i can use/modify, or example
driver to write a new one if need be.

any help is greatly appreciated

TIA
niraj gupta

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1028685867072--


