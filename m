Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269290AbUJQUb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbUJQUb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQUaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:30:03 -0400
Received: from relay.pair.com ([209.68.1.20]:25607 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269310AbUJQU3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:29:25 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4172C8E1.4080709@kegel.com>
Date: Sun, 17 Oct 2004 12:32:49 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>, albert@users.sf.net
Subject: Re: Building on case-insensitive systems and systems where -shared
 doesn't work well
References: <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk> <20041016220427.GE8765@mars.ravnborg.org> <20041017165718.GB23525@mail.13thfloor.at> <4172A0ED.9040906@kegel.com> <20041017182929.GA27637@mail.13thfloor.at> <4172B01B.5080404@kegel.com> <20041017190612.GB27637@mail.13thfloor.at>
In-Reply-To: <20041017190612.GB27637@mail.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> why not move the intermediate files into a separate
> subdirectory which can easily be removed on cleanup?

That would require zero code changes, and is a
pretty good workaround at least for my case,
where I can easily build with O=objdir.
Thanks for pointing it out!
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
