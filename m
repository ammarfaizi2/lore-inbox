Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312337AbSC3UFs>; Sat, 30 Mar 2002 15:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSC3UFi>; Sat, 30 Mar 2002 15:05:38 -0500
Received: from ns.suse.de ([213.95.15.193]:21510 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312337AbSC3UFf>;
	Sat, 30 Mar 2002 15:05:35 -0500
Date: Sat, 30 Mar 2002 21:05:34 +0100
From: Dave Jones <davej@suse.de>
To: Sebastian Roth <xsebbi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.7-dj2] No keyboard input?
Message-ID: <20020330210534.F22329@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Sebastian Roth <xsebbi@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200203302033.32284@xsebbi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 08:37:48PM +0100, Sebastian Roth wrote:
 > Hi there,
 > it seems that 2.5.7-dj2 doesn't like my keyboard. I can't type anything 
 > with it. 
 > .config is attached. 
 > Is it possible that I have an mistake at my .config?

Yup 8-)

 > # CONFIG_SERIO is not set
 > # CONFIG_SERIO_I8042 is not set

You'll need a keyboard controller..

 > # CONFIG_KEYBOARD_ATKBD is not set
 > # CONFIG_KEYBOARD_SUNKBD is not set
 > # CONFIG_KEYBOARD_PS2SERKBD is not set
 > # CONFIG_KEYBOARD_XTKBD is not set

And one of the keyboard types..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
