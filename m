Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTKLBH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 20:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTKLBH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 20:07:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51135 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261240AbTKLBH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 20:07:56 -0500
Subject: RE: 2.6.0-test9-mjb2 oops2
From: Keith Mannthey <kmannth@us.ibm.com>
To: root@www.linux.org.uk
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 11 Nov 2003 17:07:53 -0800
Message-Id: <1068599275.23335.49.camel@dyn318004.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> HW: HP 8way box

> Thoughts anyone?


It looks like you have CONFIG_x86_SUMMIT enabled in your kernel.  Having
Summit support enabled will cause you lots of problems on your 8-way HP
system :)  Please try a  different sub-arch type when you build.   

Keith 

