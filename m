Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTI3JY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTI3JY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:24:57 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:53991 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S261256AbTI3JY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:24:56 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Matroxfb still broken in -test6
Date: Tue, 30 Sep 2003 09:24:54 +0000 (UTC)
Message-ID: <slrnbniiv6.p62.erik@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matroxfb has been unusable for me since around 2.5.6x, and it still is in
-test6.

The simptoms are:

- large white bar to the right of the pengiun logo on booting
- (mostly) yellow distortion in the background: parts of the screen that
  should be black, are distorted with a semi-regular pattern. Each line of
  scrolling adds around 5 lines worth of distorion to the bottom of the
  screen. The distorion works its way up until the entire screen is filled
  with it.
  Switching to and from another vc clears it.

I could make a picture of it using the low-res (640x480) digicam on my
cellphone if anyone is interesed ;-)

Hardware: Matrox G550, CRT connected to the DVI port and TV connected to
the TV-out.
Settings: all default
Config:

CONFIG_FB=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y


-- 
Erik Hensema <erik@hensema.net>
