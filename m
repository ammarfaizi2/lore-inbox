Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTDTW2e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 18:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTDTW2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 18:28:34 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:44231 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263705AbTDTW2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 18:28:33 -0400
Subject: OpenSSH protocol version 2 doesn't support Kerberos authentication
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050878426.614.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 21 Apr 2003 00:40:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is simply an informative message.

I have just deployed Kerberos authentication on my LAN. However, I have
been smashing my head against a wall everytime I tried to configure and
use OpenSSH with Kerberos authentication.

Such situation led me to browse the OpenSSH sources and, to my dismay, I
have found that Kerberos V5 authentication is *not* implemented for
protocol version 2, only in protocol version 1. Just take a look at
sshconnect1.c and sshconnect2.c to check.

So I reconfigured all my RHL9 boxes to just use Protocol 1. Now, OpenSSH
and Kerberos work nicely and it's just beautiful to be able to log on at
my laptop and being able to ssh to any machine in my LAN without
supplying a password. This is Unix single-sign-on came true...

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

