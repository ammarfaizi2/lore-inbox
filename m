Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbULGHvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbULGHvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 02:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbULGHvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 02:51:31 -0500
Received: from mail3.mdx.safepages.com ([216.127.133.18]:25355 "EHLO
	mail3.mdx.safepages.com") by vger.kernel.org with ESMTP
	id S261777AbULGHv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 02:51:28 -0500
Subject: gameport and USB joysticks/gamepads
From: "Luis A. Montes" <luismontes@isp.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Dec 2004 23:58:57 -0800
Message-Id: <1102406337.5938.9.camel@penguin.montes2.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is the gameport_register_port() supposed to be called for USB
devices? There doesn't seem to be any kernel hook for that. Is it
supposed to happen in userspace?
Also, it seems to me that gameport_register_device is always going to
add a null pointer (dev->node) to the gameport_dev_list, and that
doesn't seem terribly useful. What's the purpose of that?

