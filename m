Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUIHFvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUIHFvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268847AbUIHFvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 01:51:11 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:11158 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268845AbUIHFvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 01:51:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm4: Makefile: remove tabs from empty lines
Date: Wed, 8 Sep 2004 00:51:02 -0500
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>
References: <20040907020831.62390588.akpm@osdl.org> <20040907190212.GB2454@fs.tum.de> <20040907211422.GA6053@mars.ravnborg.org>
In-Reply-To: <20040907211422.GA6053@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409080051.03548.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 04:14 pm, Sam Ravnborg wrote:
> Amyways I try to avoid these, but my gvim is pretty consistent in adding
> additional tabs/spaces here and there. Anyone that can tell me how to
> teach gvim not to do so (and flag trailing tabs/spaces).

I have the following in my .vimrc:

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

but I must tell you that kernel sources are pretty bloody with this ption on
(although I think I cleaned up the input subsystem ;) 

-- 
Dmitry
