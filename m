Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbSJASYG>; Tue, 1 Oct 2002 14:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262225AbSJASYF>; Tue, 1 Oct 2002 14:24:05 -0400
Received: from zeke.inet.com ([199.171.211.198]:63980 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S262174AbSJASYE>;
	Tue, 1 Oct 2002 14:24:04 -0400
Message-ID: <3D99E98A.2020002@inet.com>
Date: Tue, 01 Oct 2002 13:29:30 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jbradford@dial.pipex.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Stupid luser question
References: <200210011814.g91IEEY5007979@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pipex.com wrote:
> Just wondering, what is the purpose of the comment /* { */ which is found in various seemingly random places in the kernel:
> 
> # grep -F -r "/* { */" *
> 
> drivers/video/font_acorn_8x8.c:/* 7B */  0x0C, 0x18, 0x18, 0x70, 0x18, 0x18, 0x0C, 0x00, /* { */
[snip]

Probably folding... possibly from vim/gvim.

If you're curious, look at: http://vim.sourceforge.net/htmldoc/fold.html
:set foldmethod=marker
:set foldmarker={,}
:set foldcolumn=6
Gets folding "mostly right" for C/C++ code.  Manually added folds add in 
a C comment containing the foldmarker, in this case "/* { */"
and "/* } */"

emacs probably has this feature as well, but I'm a vim person myself. :)

If you are not familiar with folding, look into it.  I find it very 
useful when dealing with unfamiliar code or looking at program structure.

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

