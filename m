Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSFVRdj>; Sat, 22 Jun 2002 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSFVRdi>; Sat, 22 Jun 2002 13:33:38 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37310 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316789AbSFVRdi>;
	Sat, 22 Jun 2002 13:33:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 22 Jun 2002 19:33:39 +0200 (MEST)
Message-Id: <UTC200206221733.g5MHXdE08993.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, kai-germaschewski@uiowa.edu
Subject: Re: ethernet name clash at boot
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you give some more info on your config

Hmm. The more you know about my actual setup the more likely
it is that you'll only fix the symptoms.

But anyway: what happens is that a vortex card starts initializing,
gets the name eth0, but then a 3c509 also takes eth0 and registers
first. The vortex gets -EEXIST.

Andries

[Everything built-in. No modules.]

