Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271236AbRHZBmJ>; Sat, 25 Aug 2001 21:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271213AbRHZBl7>; Sat, 25 Aug 2001 21:41:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:13843 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271236AbRHZBl5>;
	Sat, 25 Aug 2001 21:41:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: jlmales@softhome.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.8 - No rule to make target `/etc/sound/dsp001.ld' 
In-Reply-To: Your message of "Sat, 25 Aug 2001 19:06:29 EST."
             <3B87F735.10072.1286FAC@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Aug 2001 11:41:36 +1000
Message-ID: <13654.998790096@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001 19:06:29 -0500, 
"John L. Males" <jlmales@softhome.net> wrote:
>I started trying out the 2.4 Kernel starting with 2.4.5 and have had
>compiling problems.  The problem is I cannot complete the compile of
>the modules due to an error "No rule to make target
>`/etc/sound/dsp001.ld".  I have expereinced this error right up to
>the 2.4.8 kernel.

You said yes to config 'Have DSPxxx.LD firmware file'
CONFIG_PSS_HAVE_BOOT and also said that the firmware file is in
/etc/sound/dsp001.ld but you do not have that file.  Turn off
CONFIG_PSS_HAVE_BOOT or provide the file, either way you need to tell
config the truth about your system.

PS.  Fix your mailer, you are sending nested PGP signatures, with
     separate signatures on the text and attachment sections.

