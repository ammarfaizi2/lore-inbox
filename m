Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132745AbRDIN3i>; Mon, 9 Apr 2001 09:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132746AbRDIN32>; Mon, 9 Apr 2001 09:29:28 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:29224 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132745AbRDIN3T>; Mon, 9 Apr 2001 09:29:19 -0400
Date: Mon, 9 Apr 2001 14:13:10 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: parport initialisation
Message-ID: <Pine.LNX.3.96.1010409141107.9826A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

regarding drivers/parport/*

is there any particular reason as to why the different parport drivers
aren't initialized using module_init() ? Like weird init order
dependencies and stuff.

Looking at parport_init itself (which has hardcoded init calls to the
different drivers right now) it does not look like it does anything
particularly special except some proc filesystem registering.

Is it just because nobody has gotten around to "fixing" it or is there a
deeper reason ?

Regards
Bjorn

