Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292970AbSCORe5>; Fri, 15 Mar 2002 12:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292981AbSCORei>; Fri, 15 Mar 2002 12:34:38 -0500
Received: from unknown.Level3.net ([64.152.86.3]:63006 "HELO [64.152.86.3]")
	by vger.kernel.org with SMTP id <S292970AbSCORe2>;
	Fri, 15 Mar 2002 12:34:28 -0500
Message-ID: <3C9231E0.8090202@esstech.com>
Date: Fri, 15 Mar 2002 11:39:44 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > If we put every single requested obscure fix for one or two boxes into
 > the kernel configuration you'd be spending weeks wading through
 >
 > "Handle weird APM on Dave's homebrew mediagx"
 >
 > and other questions.
 >

A config option that lets you pick the address for the dummy io would
be a pretty obscure option.  But having a CONFIG_POST_SUPPORT buried
somewhere wouldn't be that obscure or confusing.  If that config
option is set, then a second question would prompt for an alternate
address to be used for the delay io, and a macro would be defined to
display post codes.  If the option is unset, then 0x80 would be the
default for the delay address, and the post code macro would be defined
to do nothing.

Gerald

