Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290276AbSBGQwQ>; Thu, 7 Feb 2002 11:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBGQwG>; Thu, 7 Feb 2002 11:52:06 -0500
Received: from ns.suse.de ([213.95.15.193]:13329 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290276AbSBGQv6>;
	Thu, 7 Feb 2002 11:51:58 -0500
Date: Thu, 7 Feb 2002 17:51:54 +0100
From: Dave Jones <davej@suse.de>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Input w/2.5.3-dj3
Message-ID: <20020207175154.L22451@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Hal Duston <hald@sound.net>, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
In-Reply-To: <Pine.GSO.4.10.10202071038510.24422-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10202071038510.24422-100000@sound.net>; from hald@sound.net on Thu, Feb 07, 2002 at 10:43:06AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:43:06AM -0600, Hal Duston wrote:
 > I am not finding the correct way to have my std keyboard
 > recognized and usable under 2.5.3-dj3.  What am I
  > missing?

  What do you have the keyboard related options set to ?
  Related items on a PS2 keyboard that works here are..

  CONFIG_INPUT=y
  CONFIG_INPUT_KEYBDEV=y
  CONFIG_SERIO=y
  CONFIG_SERIO_I8042=y
  CONFIG_INPUT_KEYBOARD=y
  CONFIG_KEYBOARD_ATKBD=y
  CONFIG_KEYBOARD_XTKBD=y

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
