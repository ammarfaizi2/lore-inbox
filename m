Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266404AbUAIB6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266406AbUAIB6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:58:47 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:7887 "HELO
	develer.com") by vger.kernel.org with SMTP id S266404AbUAIB6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:58:46 -0500
Message-ID: <3FFE0AD0.7040609@develer.com>
Date: Fri, 09 Jan 2004 02:58:40 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Fredrik Olausson <fredrik@olaussons.net>
CC: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: bad scancode for USB keyboard
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com> <20040107085104.GA14771@ucw.cz> <3FFC5F68.2090009@develer.com> <3FFDF67A.5060807@olaussons.net>
In-Reply-To: <3FFDF67A.5060807@olaussons.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fredrik Olausson wrote:
> I have found a solution to the problem.
> XFree86 has 2 keyboard drivers, the default one named "keyboard" and an 
> alternative one named "kbd" which according to documentation on the 
> XFree86 website is a new keyboard driver mostly written from scratch. 
> With the kbd-driver the print-screen key and the |\-key got different 
> keycodes and thus I could make the |\-key give me the proper characters.
> 
> So, to summarize. Simply changing the line:
> Driver      "keyboard"
> to
> Driver      "kbd"
> in the input-device section in the XF86Config file and fiddling a bit 
> with xmodmap solved the problem for me.

That's good news, and I'd never heard about a new keyboard driver in
XFree86... It's indeed a project full of undocumented and obscure
features.

Err... what did you exactly say on the xmodmap command line to get
it to work? -)

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/


