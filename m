Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVCMQsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVCMQsy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVCMQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:48:54 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:696 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261368AbVCMQsw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:48:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
Subject: Re: [2.6.11.3] gcc4 / psmouse.h - compilation fix.
Date: Sun, 13 Mar 2005 11:48:45 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200503131420.12554.pluto@pld-linux.org>
In-Reply-To: <200503131420.12554.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503131148.46417.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 March 2005 08:20, Paweł Sikora wrote:
> Hi,
> 
> Attched patch fixes gcc error:
> `drivers/input/mouse/psmouse.h:40: error: field `ps2dev' has incomplete type`
> 

What file fails compilation? As far as I can see all users of psmouse.h do
#include <linux/libps2.h> first.

-- 
Dmitry
