Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263103AbSJBNZ7>; Wed, 2 Oct 2002 09:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbSJBNZ7>; Wed, 2 Oct 2002 09:25:59 -0400
Received: from carbon.btinternet.com ([194.73.73.92]:53996 "EHLO carbon")
	by vger.kernel.org with ESMTP id <S263103AbSJBNZ6>;
	Wed, 2 Oct 2002 09:25:58 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Stig Brautaset <s.brautaset@wmin.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: menuconfig: no choice of keyboards
Date: Wed, 2 Oct 2002 14:31:25 +0100
User-Agent: KMail/1.4.7
References: <20021002113053.GA482@arwen.brautaset.org>
In-Reply-To: <20021002113053.GA482@arwen.brautaset.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210021431.25941.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 12:30 pm, Stig Brautaset wrote:
> Nothing happens if I go to the "Input Device Support" section in
> menuconf, and pick "Keyboards"; I get no new options. Got around it by
> manually selecting a keyboard in .config to be able to test it further.
> Either I chose the wrong one, or it just doesn't build it anyway, 'cause
> the machine would not respond on boot.
>
> Does it have something to do with the menuconfig bug reported elsewhere?
> Here's mine, anyway:
>
> /bin/sh ./scripts/Menuconfig arch/i386/config.in
> Using defaults found in .config
> Preparing scripts: functions,
> parsing....................................................................
>....../scripts/Menuconfig: ./MCmenu74: line 56: syntax error near unexpected
> token `fi'
> ./scripts/Menuconfig: ./MCmenu74: line 56: `fi'
> ...............done.
>
> Stig

I think you need 'Serial i/o support' just above the 'Keyboards' option
