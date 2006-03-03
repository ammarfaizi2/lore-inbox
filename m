Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWCCSO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWCCSO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWCCSO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:14:57 -0500
Received: from guru.webcon.ca ([216.194.67.26]:45984 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S1161013AbWCCSO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:14:57 -0500
Date: Fri, 3 Mar 2006 13:14:55 -0500 (EST)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: linux-kernel@vger.kernel.org
Subject: Setkeycodes w/ keycode >= 0x100 ?
Message-ID: <Pine.LNX.4.64.0603031241130.15776@light.int.webcon.net>
Organization: Webcon, Inc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Assp-Spam-Prob: 0.00000
X-Assp-Whitelisted: Yes
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since my HP notebook has some unrecognized keys, I have to use setkeycodes to
make the kernel recognise them. However, many of the basic (<=255) KEY's from
input.h are not suitable, but newer ones (>=0x100) woule be perfect.

Any idea how to map scancodes to keycodes >=0x100 when setkeycodes won't
accept hex input nor anything greater than 255?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
