Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSFXDF2>; Sun, 23 Jun 2002 23:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317265AbSFXDF1>; Sun, 23 Jun 2002 23:05:27 -0400
Received: from [148.246.65.242] ([148.246.65.242]:1028 "EHLO zion.sytes.net")
	by vger.kernel.org with ESMTP id <S317263AbSFXDF1>;
	Sun, 23 Jun 2002 23:05:27 -0400
Date: Sun, 23 Jun 2002 22:05:10 -0500
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Subject: buffer_boundary isn't defined
Message-ID: <20020624030510.GA119@zion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Doing some hacking I found something weird since 2.5.19, buffer_boundary and
set_buffer_boundary are not defined, at least greping the source tree I couldn't
find where they could be defined.

The weird thing is that kbuild doesn't report that.

-- 
Felipe Contreras
