Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTGTJSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 05:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbTGTJSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 05:18:13 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:27266 "EHLO server")
	by vger.kernel.org with ESMTP id S265976AbTGTJSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 05:18:10 -0400
Message-ID: <004b01c34ea1$ed474d00$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20030720032943.GA12272@gtf.org>
Subject: Tulip and Adaptec 6922
Date: Sun, 20 Jul 2003 02:33:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
    I noticed a problem with the tulip driver on this particular card, it
may just be me. I have the adaptec 6922 dual port card installed in my
server, runs great with the tulip driver, but at start up I have do
something that is quite not the norm.  Most of the time it works, if I do a
warm restart but I do a cold restart I have to do the following to get my
network card to recoginze both ports.

Boot up and wait till everything is loaded, stop the network services.
Remove the tulip driver. Modprobe the tulip driver and restart network
services, and then I either start all the services looking for the eth1
adapter or just do a warm boot.

If you need a card to play around with, I have a spare one laying around I
can send you.

