Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUBJS0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUBJS0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:26:24 -0500
Received: from terminus.zytor.com ([63.209.29.3]:55222 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266090AbUBJSZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:25:41 -0500
Message-ID: <4029221C.7060805@zytor.com>
Date: Tue, 10 Feb 2004 10:25:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Very preliminary dynamic pty patch
References: <c0b46g$ulg$1@terminus.zytor.com> <200402101803.i1AI3imE010142@turing-police.cc.vt.edu>
In-Reply-To: <200402101803.i1AI3imE010142@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 10 Feb 2004 17:25:36 GMT, hpa@zytor.com (H. Peter Anvin)  said:
> 
>>Try it out and send me the oopsen :)
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/dynpty-test-1.patch
> 
> Eyeball checked only, 2 comments:
> 
> 1) Will the embedded crew object to the removal of CONFIG_UNIX98_PTYS?
> I can see some systems that don't want either SysV or BSD pty's, unless
> they're deeply ingrained in some way I don't understand so you can't have
> a system with exactly one tty on a DB-9 serial port for a console without 
> having them present too.
> 
> 2) How much extra code to axe the BSD-style PTYs?

Actually it looks like it wouldn't be too much code either way.  I'll 
probably make them both config options (with removal of the entire pty 
subsystem if one chooses no on both.)

	-hpa
